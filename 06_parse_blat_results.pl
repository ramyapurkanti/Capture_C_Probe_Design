#!/usr/bin/perl
#Counting number of off-targets 
@Passemblies=("All_assemblies_pooled","GRCz11","GRCz11_Yang-chr4","ABH","TuH");
@Tassemblies=("GRCz11","GRCz11_Yang-chr4","ABH","TuH");
@uniqprobes_num=(126,8,72,20,56);

#Including chr10 patch as part of miR430 cluster
#@nummir430clust=(2,4,3,4);
#@mir430_coords=("chr4:28693255-29709534","chr10:4493277-4493358","chr4:29894550-29951130","chr4:30450269-30456650","chr4:30476084-30496498","chr10:4493277-4493358","chr4:29231058-29249822","chr4:29895628-29911326","chr10:4452990-4452909","chr4:30755157-30811098","chr4:31007527-31013911","chr4:31278641-31284206","chr10:4394268-4394187");

#Not including chr10 miR430 cluster
@nummir430clust=(1,3,2,3);
@mir430_coords=("chr4:28693255-29709534","chr4:29894550-29951130","chr4:30450269-30456650","chr4:30476084-30496498","chr4:29231058-29249822","chr4:29895628-29911326","chr4:30755157-30811098","chr4:31007527-31013911","chr4:31278641-31284206");
$cnt=0;
for($i=0;$i<scalar @Tassemblies;$i++){
	for($j=1;$j<=$nummir430clust[$i];$j++){
		$coords{$Tassemblies[$i]}{$j}=$mir430_coords[$cnt];
		$cnt++;
	}
}
#Blat_results/ABH_miR430_probes_Blatgenome_ABH.psl
#psLayout version 3
#  
#match   mis-    rep.    N's     Q gap   Q gap   T gap   T gap   strand  Q               Q       Q       Q       T               T       T       T       block   blockSizes      qStarts  tStarts
#        match   match           count   bases   count   bases           name            size    start   end     name            size    start   end     count
#---------------------------------------------------------------------------------------------------------------------------------------------------------------
#70      0       0       0       0       0       0       0       +       ABH_miR430_Probe1       70      0       70      chr4    51234560        29247962        29248032        1       70,     0,      29247962,
for($i=0;$i<scalar @Passemblies;$i++){
	for($j=0;$j<scalar @Tassemblies;$j++){
		$filename1="Blat_results/".$Passemblies[$i]."_miR430_probes_Blatgenome_".$Tassemblies[$j].".psl";
		open F1, $filename1 or die;
		for($k=1;$k<=5;$k++){$line=<F1>;}
		while($line=<F1>){
			chomp $line;
			@spl = split "\t", $line;
			@probenum=split /Probe/,$spl[9];$pnum=$probenum[1];
			if($i ==0){$probeid{$pnum}=$spl[9];}
			#Checking whether match is within miR430 region or NOT
			$flg=0;
			foreach $k(keys %{$coords{$Tassemblies[$j]}}){
				@cd=split /[:-]+/, $coords{$Tassemblies[$j]}{$k};
				if($cd[0] eq $spl[13]){
					if(($spl[15]>=$cd[1] and $spl[15]<=$cd[2]) or 
						($spl[16]>=$cd[1] and $spl[16]<=$cd[2]) or 
						($cd[1]>=$spl[15] and $cd[1]<=$spl[16]) or 
						($cd[2]>=$spl[15] and $cd[2]<=$spl[16])){
							$flg++;
					}
				}
			}
			
			if($flg!=0){$cnt{$Passemblies[$i]}{$pnum}{$Tassemblies[$j]}{"miR430"}++;}
			else{$cnt{$Passemblies[$i]}{$pnum}{$Tassemblies[$j]}{"off-target"}++;}
		}
		close F1;
	}
}
open F2, ">Number_hits_per_probe_summarised.txt" or die;
print F2 "Probe_Genome\tProbe_Number";
for($i=0;$i<scalar @Tassemblies;$i++){
	print F2 "\t$Tassemblies[$i]_miR430_hits\t$Tassemblies[$i]_Off-target_hits";
}
print F2 "\n";
for($i=0;$i<scalar @Passemblies;$i++){
	for($n=1;$n<=@uniqprobes_num[$i];$n++){
		#print F2 "$Passemblies[$i]\tmiR430_Probe$n";
		if($i==0){print F2 "$Passemblies[$i]\t$probeid{$n}";}
		else{print F2 "$Passemblies[$i]\t$Passemblies[$i]_miR430_Probe$n";}
		for($j=0;$j<scalar @Tassemblies;$j++){
			$k1="miR430";$k2="off-target";
			if(! exists $cnt{$Passemblies[$i]}{$n}{$Tassemblies[$j]}{$k1}){$cnt{$Passemblies[$i]}{$n}{$Tassemblies[$j]}{$k1}=0;}
			if(! exists $cnt{$Passemblies[$i]}{$n}{$Tassemblies[$j]}{$k2}){$cnt{$Passemblies[$i]}{$n}{$Tassemblies[$j]}{$k2}=0;}
			print F2 "\t$cnt{$Passemblies[$i]}{$n}{$Tassemblies[$j]}{$k1}\t$cnt{$Passemblies[$i]}{$n}{$Tassemblies[$j]}{$k2}";
		}
		print F2 "\n";
	}
}

