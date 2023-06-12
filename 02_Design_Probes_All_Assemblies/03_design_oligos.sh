
#module load gcc/10.4.0 python/3.7.10
#conda activate env_oligo

#GRCz11
cd /scratch/rpurkant/3C_Probe_Design/3C_oligos/GRCz11 
#python /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/oligo/design.py Tiled -f /scratch/rpurkant/3C_Probe_Design/Genome_Indexes/GRCz11_genome_index/danRer11_chr1-chr25.fa -g zf -c 4 -r 28693255-28709534 -e DpnII -o 70 -s /scratch/rpurkant/3C_Probe_Design/Genome_Indexes/GRCz11_genome_index/
mkdir miR430_cluster1
cd miR430_cluster1
python /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/oligo/design.py Tiled -f /scratch/rpurkant/3C_Probe_Design/Genome_Indexes/GRCz11_genome_index/danRer11_chr1-chr25.fa -g zf -c 4 -r 28693255-28709534 -e DpnII -o 70 --blat


#GRCz11_Yang-chr4
cd /scratch/rpurkant/3C_Probe_Design/3C_oligos/GRCz11_Yang-chr4
mkdir miR430_cluster1
cd miR430_cluster1
python /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/oligo/design.py Tiled -f /scratch/rpurkant/3C_Probe_Design/Genome_Indexes/GRCz11_Yang_chr4_genome_index/danRer11_chr4-Yang_chr1-chr25.fa -g zf -c 4 -r 29894550-29951130 -e DpnII -o 70 --blat
mkdir ../miR430_cluster2
cd ../miR430_cluster2
python /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/oligo/design.py Tiled -f /scratch/rpurkant/3C_Probe_Design/Genome_Indexes/GRCz11_Yang_chr4_genome_index/danRer11_chr4-Yang_chr1-chr25.fa -g zf -c 4 -r 30450269-30456650 -e DpnII -o 70 --blat
mkdir ../miR430_cluster3
cd ../miR430_cluster3
python /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/oligo/design.py Tiled -f /scratch/rpurkant/3C_Probe_Design/Genome_Indexes/GRCz11_Yang_chr4_genome_index/danRer11_chr4-Yang_chr1-chr25.fa -g zf -c 4 -r 30476084-30496498 -e DpnII -o 70 --blat

#ABH
cd /scratch/rpurkant/3C_Probe_Design/3C_oligos/ABH/
mkdir miR430_cluster1
cd miR430_cluster1
python /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/oligo/design.py Tiled -f /scratch/rpurkant/3C_Probe_Design/Genome_Indexes/ABH_genome_index/fDreABH1_chr1-chr25.fa -g zf -c 4 -r 29231058-29249822 -e DpnII -o 70 --blat
mkdir ../miR430_cluster2
cd ../miR430_cluster2
python /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/oligo/design.py Tiled -f /scratch/rpurkant/3C_Probe_Design/Genome_Indexes/ABH_genome_index/fDreABH1_chr1-chr25.fa -g zf -c 4 -r 29895628-29911326 -e DpnII -o 70 --blat


#TuH
cd /scratch/rpurkant/3C_Probe_Design/3C_oligos/TuH/
mkdir miR430_cluster1
cd miR430_cluster1
python /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/oligo/design.py Tiled -f /scratch/rpurkant/3C_Probe_Design/Genome_Indexes/TuH_genome_index/fDreTuH1_chr1-chr25.fa -g zf -c 4 -r 30755157-30811098 -e DpnII -o 70 --blat
mkdir ../miR430_cluster2
cd ../miR430_cluster2
python /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/oligo/design.py Tiled -f /scratch/rpurkant/3C_Probe_Design/Genome_Indexes/TuH_genome_index/fDreTuH1_chr1-chr25.fa -g zf -c 4 -r 31007527-31013911 -e DpnII -o 70 --blat
mkdir ../miR430_cluster3
cd ../miR430_cluster3
python /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/oligo/design.py Tiled -f /scratch/rpurkant/3C_Probe_Design/Genome_Indexes/TuH_genome_index/fDreTuH1_chr1-chr25.fa -g zf -c 4 -r 31278641-31284206 -e DpnII -o 70 --blat
