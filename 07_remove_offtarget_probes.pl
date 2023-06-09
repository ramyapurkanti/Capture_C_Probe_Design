#!/usr/bin/perl
open F1, "3C_70bp_oligos/All_assemblies_pooled_uniq_mir430probes.fa" or die;
#>ABH_Probe1
#GATCACTTCAAACAGGAGCATTGATTTGTCCTTTGTTCATAAGTGCTTCTCTTTGGGGTAGTTTTATAAA

#On parsing file Number_hits_per_probe_summarised.txt, the probes with offtargets were 15,23,33,36,41,62,67,69,72,73,78,84,87,108,117 and 125
@offtarget=(23,30,33,35,49,53,76,78,84,92,98,104,112,115,121,122,123);
open F2, ">3C_70bp_oligos/All_assemblies_pooled_uniq_mir430probes_filter.fa" or die;

while($id1=<F1>){
	chomp $id1;
	$seq=<F1>;chomp $seq;
	@tmp = split "Probe",$id1;$id=$tmp[1];
	#	$id =~ s/>All_assemblies_pooled_miR430_Probe//;
	if(!($id ~~ @offtarget)){
		print F2 "$id1\n$seq\n";
	}
}
