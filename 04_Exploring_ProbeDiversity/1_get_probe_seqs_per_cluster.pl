#!/usr/bin/perl
open F1, "../Final_miR430_70bp_probes_DpnII.fa" or die;
#>miR430_Probe1
#GATCTTAATGTGTTTAGATGCAGATGTCACTGTAAATTCCAAAAGACAACACTCTCTTGTAGCACAGGTC
while($id=<F1>){
	chomp $id;$id=~ s/>miR430_Probe//;
	$seq{$id}=<F1>;chomp $seq{$id};
}
#Probe_cluster1
for($n=1;$n<=5;$n++){
	$fname="Probe_cluster".$n;
	$fname_2="Probe_cluster".$n."_seqs.fa";
	print "$fname\t$fname_2\n";
	open F2, $fname or die;
	open F3, ">".$fname_2 or die;
	while($line=<F2>){
		chomp $line;
		print F3 ">miR430_Probe".$line."\n".$seq{$line}."\n";
		delete $seq{$line}
	}
}
open F3, ">Unclustered_probes.fa" or die;
foreach $k(keys %seq){
	print F3 ">miR430_Probe".$k."\n".$seq{$k}."\n";
}
