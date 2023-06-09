#!/usr/bin/perl
open F1, "Probes_all_agnst_all_blast.out" or die;
#miR430_Probe1	miR430_Probe1	100.000	70	0	0	1	70	1	70	2.06e-34	130
#miR430_Probe1	miR430_Probe99	98.571	70	1	0	1	70	1	70	9.59e-33	124
open F2, ">CLANS/Probes_attractionvals.clans" or die;
$mx=-1;
while($line=<F1>){
	chomp $line;
	@spl = split "\t", $line;
	$id1=$spl[0];$id1=~s/miR430_Probe//;
	$id2=$spl[1];$id2=~s/miR430_Probe//;
	$att_val{$id1}{$id2}=-1*log($spl[10]);
	if($id1 != $id2){if($att_val{$id1}{$id2}>$mx){$mx=$att_val{$id1}{$id2};}}
}
foreach $k1(sort{$a<=>$b} keys %att_val){
	foreach $k2(sort{$a<=>$b} keys %{$att_val{$k1}}){
		if($k1 != $k2){
			$att_val{$k1}{$k2}=$att_val{$k1}{$k2}/$mx;
			print F2 "$k1 $k2 $att_val{$k1}{$k2}\n";
		}
	}
}
