Prepare genome assemblies and identify miR430 coordinates against each of the assemblies

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

