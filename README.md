# Capture_C_Probe_Design
Designing probes for Capture-C experiment
In order to deduce genomic interaction of a locus of interest, I am desiging 70bp probes spanning the locus of interest for the pull-down step. Here we are interested in desiging Tiled-C probes for miR430 locus in zebrafish genome as per Downes et al., 2022. 

Note: There are two specific challenges:
(1) miR430 locus is a repetitive locus
(2) We do not trust the mir430 locus assembly in the primary reference GRCz11. Hence we want to design probes which are "universal" i.e. works against any zebrafish strain (AB, TU, TL etc)

The detailed steps for probe design are listed below:

Setting up the environment
-
```
git clone https://github.com/jbkerry/oligo.git

Creating a virtual environment with all dependencies for the first time:
module load gcc/10.4.0 python/3.7.10
conda create --name env_oligo #environment location: /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/conda_envs/env_oligo
conda activate env_oligo
conda install numpy=1.15.4
conda install pandas=0.25.1
pip install 'pysam==0.21.0'
pip install 'biopython==1.81'

Changed config.txt file to give paths:
Path for repeatmasker = /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/RepeatMasker
STAR_PATH = /dcsrsoft/spack/arolle/v1.0/spack/opt/spack/linux-rhel8-zen2/gcc-10.4.0/star-2.7.6a-my53qpmt53edtqiipk2cbf7xsgh52k55/bin
BLAT_PATH = /dcsrsoft/spack/arolle/v1.0/spack/opt/spack/linux-rhel8-zen2/gcc-10.4.0/blat-433-xbfag5n7xerft7q3l36vf5gorljrzjfe/bin


module load gcc/10.4.0 python/3.7.10
conda activate env_oligo
python /work/FAC/FBM/CIG/nvastenh/omics/RAMYA/Softwares/oligo/design.py

```

Step 1: Prepare the genome assembly and extract the coordinates of the miR430 locus 
-
```
01_Prepare_Genome_target_coord
```

Step2: Desiging Probes against all assemblies
-
```
02_Design_Probes_All_Assemblies
```
Step3: Combining probes from multiple assemblies into a universal probe list
-
```
03_Compile_Universal_ProbeList
```
Step4: Visualizing sequence diversity of designed probes using CLANS
-
```
04_Exploring_ProbeDiversity
```
