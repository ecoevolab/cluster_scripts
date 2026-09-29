#!/bin/bash

#SBATCH --job-name=RP_antismash
#SBATCH --output=%x.log
#SBATCH --error=%x.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4:00:00        # hh:mm:ss
#SBATCH --mem=8G         # total memory per node


echo "===== Starting job ($SLURM_JOB_ID) ====="
date

source  $GROUP_HOME/modules/pkgs/mamba/main/etc/profile.d/conda.sh
conda activate antismash5

mkdir antismash


for f in fnas/*; do
        GID=`basename $f` 
        GID=`echo $GID | sed 's/\.fna$//'`
        echo $GID

	antismash --cpus 1 \
                  --taxon bacteria \
                  --cf-create-clusters \
		  --cb-general \
		  --cb-subclusters \
		  --cb-knownclusters \
		  --asf \
		  --pfam2go \
		  --output-dir antismash/$GID \
  		  --genefinding-gff3 gffs/$GID.gff $f
done

echo "===== Ending job ($SLURM_JOB_ID) ====="
date

echo "===== sacct ====="
sleep 5
sacct -j $SLURM_JOB_ID --format=JobID,JobName,Elapsed,MaxRSS,MaxVMSize,TotalCPU,ReqMem,State,ExitCode

