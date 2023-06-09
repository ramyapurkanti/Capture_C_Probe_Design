# Capture_C_Probe_Design
Designing probes for Capture-C experiment
In order to deduce genomic interaction of a locus of interest, I am desiging 70bp probes spanning the locus of interest for the pull-down step. 

The detailed steps for probe design are listed below:
****************
Creating a cirtual environment with all dependencies for teh first time:
module load gcc/10.4.0 python/3.7.10
conda create --name env_oligo #environment location: /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/conda_envs/env_oligo
conda activate env_oligo
conda install numpy=1.15.4
conda install pandas=0.25.1
pip install 'pysam==0.21.0'
pip install 'biopython==1.81'

Changed config.txt file to give paths:
Path for repeatmasker = /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/RepeatMasker
STAR_PATH = /dcsrsoft/spack/arolle/v1.0/spack/opt/spack/linux-rhel8-zen2/gcc-10.4.0/star-2.7.6a-my53qpmt53edtqiipk2cbf7xsgh52k55/bin
BLAT_PATH = /dcsrsoft/spack/arolle/v1.0/spack/opt/spack/linux-rhel8-zen2/gcc-10.4.0/blat-433-xbfag5n7xerft7q3l36vf5gorljrzjfe/bin


module load gcc/10.4.0 python/3.7.10
conda activate env_oligo
python /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/oligo/design.py


Step1: Make Genome indexes using STAR
Note: The probe design script (design.py) expects chromosomes to start with "chr" followed by the number. I modified the script so that it accepts numbers till chr25. 
The ABH and TuH genomes do not start with chr so will rename the chromosome names. Also, since it cannot use contig information, I am going to remove that as well for all assemblies.

perl Genome_Indexes/1_rename_chromosome.pl
sbatch 01_index_genomes.run

Step2: Get miR430 coordinates on these assemblies
I made blast ddabases for each of teh assemblies and ran blast to get miR430 coordinates.
sbatch 02_get_miR430_coords.run

miR430 coordinates:
GRCz11:
	cluster1: chr4:28,693,255-28,709,534
ABH:
	cluster1: chr4:29,231,058-29,249,822
	cluster2: chr4:29,895,628-29,911,326
TuH:
	cluster1: chr4:30,755,157-30,811,098
	cluster2: chr4:31,007,527-31,013,911
	cluster3: chr4:31,278,641-31,284,206
GRCz11-Yang-chr4:
	cluster1: chr4:29,894,550-29,951,130
	cluster2: chr4:30,450,269-30,456,650
	cluster3: chr4:30,476,084-30,496,498

Step3: Designing Probes
#commented out line#80 from RepeatMasker/Taxonomy.pm 
#Changed oligo/Tools.py to accept zebrafish genome
I can either use blat for aligning or STAR. I will use Blat to detect the off-targets since it lists a lot of partial matches as well. However, I will look at off-targets later on after I have listed all the unique probes first. 
Command for using STAR:
python /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/oligo/design.py Tiled -f /scratch/rpurkant/3C_Probe_Design/Genome_Indexes/GRCz11_genome_index/danRer11_chr1-chr25.fa -g zf -c 4 -r 28693255-28709534 -e DpnII -o 70 -s /scratch/rpurkant/3C_Probe_Design/Genome_Indexes/GRCz11_genome_index/
Command for using BLAT:
python /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/oligo/design.py Tiled -f /scratch/rpurkant/3C_Probe_Design/Genome_Indexes/GRCz11_genome_index/danRer11_chr1-chr25.fa -g zf -c 4 -r 28693255-28709534 -e DpnII -o 70 --blat


#module load gcc/10.4.0 python/3.7.10
#conda activate env_oligo
sh 03_design_oligos.sh


Step4: Making a list of unique oligos for each assembly and count the number of times it binds within miR430 region, outside miR430 region both for same assembly and other assemblies.

A very important point: The way the program outputs the left and right probes (L and R); the L probes start with GATC whereas R probes end with GATC. This means that we catch the bottom strand using either probes. That sounds wrong. Aso, if biotin is attached to the 5' ends of the probes then R probe's biotin would be away frpm the cut site. I think we need to take reverse-complement of the R probes which the software returns.
I am taking reverse complement of all R probes such that all probes beging with GATC and biotin is attached next to ct site for each case.

perl 04_make_unique_probe_list.pl

For off-targets, its very difficult to know what is an off-target. For now I will just blat the unique probes against its own and other assemblies. Then I will parse it later with the different criterion.
05_blat_probes_against_genomes.run 

I tabulated teh number of offtargets for each probe against each assembly in the file Number_hits_per_probe_summarised.txt. Actually, in practise it was really easy to identify the off-targetprobes. From the pooled unique miR430 probes, the offtagrets probe numbers were 23,30,33,35,49,53,76,78,84,92,98,104,112,115,121,122,123.

perl 06_parse_blat_results.pl 
07_remove_offtarget_probes.pl

Step5: Finding any probes which are complementary to one another to prevent dimerization especially since we will be using them as a cocktail
For this, I plan to first take a reverse complement of R probes (so that they too begin with GATC giving us biotin towards the cut site for all probes). Then I will do an all-against-all blast and parse the alignments

Another important thing is: we are going to be using a cocktail of probes for our pulldown and NOT use each probe as an independent view point. What this means is that we will end up with an enrichment bias for intra-miR430 interactions since such ligated products would be pulled down by multiple probes. The way we will work around this is to do a very DEEP sequencing such that we catch all trans interactions as well. To note, that the relative proportions of intra versus inter interactions will NOT be reflective of their actual levels of occurence.

BEWARE: We have to be beware of any probes which are hybridising with another (making kinda primer dimers).
sh 08_all_against_all_blast.sh
09_detect_complementary_probes.pl

I found that probe#85 and probe#105 are both complementary to one another so removing probe 85 as well leaving us with a final list of 108 probes.

Step6: Make a bed file or gff file to visualize the probes binding sites on each of the assemblies 
Step7: Make a CLANS pairwise attraction values file to see the clusters of different probes

perl 11_make_CLANS_input_cluster_probes.pl
java -jar clans.jar -load Probes_attractionvals.clans 
