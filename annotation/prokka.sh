#!/bin/bash

#SBATCH --job-name=RP_prokka
#SBATCH --output=%x.log
#SBATCH --error=%x.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=20:00:00        # hh:mm:ss
#SBATCH --mem=6G         # total memory per node


echo "===== Starting job ($SLURM_JOB_ID) ====="
date

source  $GROUP_HOME/modules/pkgs/mamba/main/etc/profile.d/conda.sh
conda activate prokka

mkdir prokka

for f in fnas/*; do
        GID=`basename $f` 
        GID=`echo $GID | sed 's/\.fna$//'`
        echo $GID

        prokka --outdir prokka/$GID --prefix $GID --cpus 4 $f
done

echo "===== Ending job ($SLURM_JOB_ID)====="
date

echo "===== sacct ====="
sleep 5
sacct -j $SLURM_JOB_ID --format=JobID,JobName,Elapsed,MaxRSS,MaxVMSize,TotalCPU,ReqMem,State,ExitCode
