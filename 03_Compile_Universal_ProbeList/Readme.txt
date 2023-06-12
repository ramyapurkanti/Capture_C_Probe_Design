
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
