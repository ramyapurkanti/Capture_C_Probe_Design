Designing Probes

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
