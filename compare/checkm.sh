#!/bin/bash

#SBATCH --job-name=checkm
#SBATCH --output=%x.log
#SBATCH --error=%x.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=40:00:00        # hh:mm:ss
#SBATCH --mem=120G         # total memory per node


echo "===== Starting job ($SLURM_JOB_ID) ====="
date

source  $GROUP_HOME/modules/pkgs/mamba/main/etc/profile.d/conda.sh
conda activate checkm
≈
checkm lineage_wf --genes --extension faa --threads 1 faas/ checkm

echo "===== Ending job ($SLURM_JOB_ID) ====="
date

echo "===== sacct ====="
sleep 5
sacct -j $SLURM_JOB_ID --format=JobID,JobName,Elapsed,MaxRSS,MaxVMSize,TotalCPU,ReqMem,State,ExitCode
