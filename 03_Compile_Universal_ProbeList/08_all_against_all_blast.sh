module load gcc/10.4.0 blast-plus/2.12.0
blastn -query  3C_70bp_oligos/All_assemblies_pooled_uniq_mir430probes_filter.fa -subject 3C_70bp_oligos/All_assemblies_pooled_uniq_mir430probes_filter.fa -outfmt 6  -out Probes_all_agnst_all_blast.out

