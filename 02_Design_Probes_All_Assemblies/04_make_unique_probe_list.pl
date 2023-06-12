#!/usr/bin/perl
@assemblies=("GRCz11","GRCz11_Yang-chr4","ABH","TuH");
@nummir430clust=(1,3,2,3);
open F3, ">3C_70bp_oligos/All_assemblies_pooled_uniq_mir430probes.fa" or die;
open F4, ">3C_70bp_oligos/PooledProbeNum_Assembly_Map.tab\t" or die;
%seq_all=();
for($i=0;$i<scalar @assemblies;$i++){
	$filename1="3C_70bp_oligos/".$assemblies[$i]."/".$assemblies[$i]."_uniq_mir430probes.fa";
	open F1, ">".$filename1 or die;
	%seq=();
	for($j=1;$j<=$nummir430clust[$i];$j++){
		$filename2="3C_70bp_oligos/".$assemblies[$i]."/miR430_cluster".$j."/oligo_seqs.fa";
		print "$filename2\n";
		open F2, $filename2 or die;
		while($id=<F2>){
			chomp $id;
			$seq1=<F2>;chomp $seq1;
			#Taking reverse complement of R probes
			if($id =~ m/-R$/){$revseq = reverse $seq1; $revseq=~ tr/ATGCatgc/TACGtacg/;$seq1=$revseq;}
			$seq{$seq1}++;
		}
		close F2;
	}
	$cnt=1;
	foreach $s(keys %seq){
		print F1 ">".$assemblies[$i]."_miR430_Probe".$cnt."\n$s\n";
		if(exists $seq_all{$s}){$seq_all{$s}.=", ".$assemblies[$i];}
		else{$seq_all{$s}=$assemblies[$i];}
		$cnt++;
	}
	close F1;
}
$cnt=1;
foreach $s(keys %seq_all){
	$id="miR430_Probe".$cnt;
	print F3 ">$id\n$s\n";
	print F4 "$id\t$seq_all{$s}\n";
	$cnt++;
}
