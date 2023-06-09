#!/usr/bin/perl
open F1, "3C_70bp_oligos/Final_miR430_70bp_probes_DpnII.fa" or die;
#>miR430_Probe1
#GATCTTAATGTGTTTAGATGCAGATGTCACTGTAAATTCCAAAAGACAACACTCTCTTGTAGCACAGGTC
while($id=<F1>){
	chomp $id;$id=~s/>//;
	$seq=<F1>;
	$select{$id}=1;
}
@assemblies=("GRCz11","GRCz11_Yang-chr4","ABH","TuH");
for($i=0;$i<scalar @assemblies;$i++){
	$fname1="Blat_results/All_assemblies_pooled_miR430_probes_Blatgenome_".$assemblies[$i].".psl";
	$fname2="BedFiles/Final_miR430_70bp_probes_DpnII_genome_".$assemblies[$i].".bed";
	open F2, $fname1 or die;open F3, ">".$fname2 or die;
	#psLayout version 3
	#
	#match   mis-    rep.    N's     Q gap   Q gap   T gap   T gap   strand  Q               Q       Q       Q       T               T       T       T       block   blockSizes      qStarts  tStarts
	#        match   match           count   bases   count   bases           name            size    start   end     name            size    start   end     count
	#---------------------------------------------------------------------------------------------------------------------------------------------------------------
	#70      0       0       0       0       0       1       1       -       miR430_Probe1   70      0       70      chr4    51234560        29231760        29231831        2       58,12,  0,58,   29231760,29231819,
	#70      0       0       0       0       0       1       1       -       miR430_Probe1   70      0       70      chr4    51234560        29235227        29235298        2       58,12,  0,58,   29235227,29235286,
	
	for($n=1;$n<=5;$n++){$line=<F2>};
	while($line=<F2>){
		chomp $line;
		@spl = split "\t", $line;
		if(exists $select{$spl[9]}){
			print F3 "$spl[13]\t$spl[15]\t$spl[16]\t$spl[9]\t0\t$spl[8]\t$spl[15]\t$spl[16]\t$spl[17]\t$spl[18]\t$spl[20]\n";
		}
	}
}
