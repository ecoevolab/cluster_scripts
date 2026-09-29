#!/bin/bash

#SBATCH --job-name=orthofinder
#SBATCH --output=%x.log
#SBATCH --error=%x.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=20:00:00        # hh:mm:ss
#SBATCH --mem=6G         # total memory per node


echo "===== Starting job ($SLURM_JOB_ID) ====="
date

module load orthofinder
mkdir orthofinder

orthofinder \
    -f genomes/ \
    -o orthofinder/ \
    -t $SLURM_CPUS_PER_TASK \
    -a $SLURM_CPUS_PER_TASK

echo "===== Ending job ($SLURM_JOB_ID)====="
date

echo "===== sacct ====="
sleep 5
sacct -j $SLURM_JOB_ID --format=JobID,JobName,Elapsed,MaxRSS,MaxVMSize,TotalCPU,ReqMem,State,ExitCode
