#!/usr/bin/perl
#To identify any probes which are reverse complements of each other
open F1, "Probes_all_agnst_all_blast.out" or die;
#ABH_Probe1      ABH_Probe1      100.000 70      0       0       1       70      1       70      2.06e-34        130
#ABH_Probe1      TuH_Probe112    100.000 69      0       0       1       69      1       69      7.42e-34        128
while($line=<F1>){
	chomp $line;
	@spl = split "\t", $line;
	if($spl[8]>$spl[9]){
		print "$spl[0]\t$spl[1]\n";
	}
}

#Probe 85 and 105 are complementary. Removing #85 since it has one extra offtarget than 105.
$remove{"miR430_Probe85"}=1;
open F1, "3C_70bp_oligos/All_assemblies_pooled_uniq_mir430probes_filter.fa" or die;
#>ABH_Probe1
#GATCACTTCAAACAGGAGCATTGATTTGTCCTTTGTTCATAAGTGCTTCTCTTTGGGGTAGTTTTATAAA
open F2, ">3C_70bp_oligos/Final_miR430_70bp_probes_DpnII.fa" or die;


while($id=<F1>){
	chomp $id;$id=~ s/>//;
	$seq=<F1>;chomp $seq;
	if(! exists $remove{$id}){
		print F2">$id\n$seq\n";
	}
}
