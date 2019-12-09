# slurm

## Definition

<span id='question-what-does-slurm-mean'></span> SLURM refers to the "Simple Linux Utility for Resource Management" and is a job manager for high performance computing.

## Commands

### Quick Start

<span id='question-what-are-commands-to-get-started-with-slurm'></span> It's sometimes easiest to get started by trying out some commands.

What Jobs are currently running?
```bash
qstat
```

What Jobs am I currently running?

```bash
qstat -u username
```

Launch an interactive session on one node with 16 cores:
```bash
qrsh -pe omp 16
```

Launch a batch job one node with 16 cores:
```bsah
qsub -pe omp 16 script.sh``
```

Cancel a batch job
```bash
qdel -j jobID
```

Cancel all my jobs

```bash
qdel -u username
```

## Examples

Here are a few more detailed examples

### Batch Scripts

**Simple One Node**
Example batch file with directives that reserve one node in the default queue, with 16 cores and exclusive use of the node:

<span id="example-sbatch-with-one-node-default-queue"></span>

```bash
#!/bin/bash
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=1:00:00
#SBATCH --exclusive
<<shell commands that set up and run the job>>
```

**Modified Memory and Time**
The job below asks for 16GB and can run up to 48 hours.

<span id='example-sbatch-on-slurm-with-modified-memory-and-time'></span>

```bash
#!/bin/bash
#SBATCH --job-name=allthesmallthings
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=16GB
```

**Using GPUs**
To modify your sbatch script for a GPU, you need to add both `--gres` and `--partition`

<span id='example-sbatch-script-using-slurm-with-gpu'></span>

```bash
#!/bin/bash
#SBATCH --job-name=cron
##SBATCH --begin=now+7days
##SBATCH --dependency=singleton
#SBATCH --time=00:02:00
#SBATCH --mail-type=FAIL
#SBATCH -p gpu
#SBATCH -c 1
#SBATCH --gres gpu:1

# Load modules here
ml load gromacs/2016.3

# Run your script
/bin/bash /scratch/users/pancakes/runMe.sh
```

**Long Running Jobs**

Let's say you have a long running job with low memory, and the memory grows over time. Here is an example that would make sure that the job goes for 3 days. The QOS (quality of service) directive tells the job manager that the job will be running longer than a day.

<span id='example-slurm-long-running-job-sbatch'></span>

```bash
#!/bin/bash
#SBATCH --job-name=normaljob
#SBATCH -p normal
#SBATCH --qos=long
#SBATCH --time=3-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=300000
ml load system devel
srun /bin/bash /scratch/users/minniemouse/myJob.sh
```

**Submit without Job File**
You can submit a job directly (on the command line) without a job file.  The same SBATCH directives at the top become the parameter.

<span id='example-submission-without-jobfile-slurm'></span>

```bash
sbatch --job-name=$job_name -o $job_name.%j.out -e $job_name.%j.err /scratch/users/smiley/scripts/makeSmiles.sh ${file1} ${file2}
```

**Google Drive Sync**

<span id='example-google-drive-sync-with-sbatch-on-slurm'></span>

```bash
#!/bin/bash 
#SBATCH --job-name=gdrive
#SBATCH --output=/home/users/julienc/logs/gdrive.out
#SBATCH -p agitler
#SBATCH --time=7-0      ## To be used with --qos=long
#SBATCH --cpus-per-task=1
#SBATCH --begin=now+48hour
#SBATCH --dependency=singleton

module load system gdrive
date

# Example of delete, where the string at the end is the file id on Google Drive
gdrive sync upload --keep-local --delete-extraneous $OAK/Shared/Potatoes/ sdhfshds3u39ur93rioneksfser
```


## Tools

<span id='question-what-tools-exist-to-help-with-using-slurm'></span> The following tools are useful for interacting or otherwise using SLURM.

 - [JobMaker](https://researchapps.github.io/job-maker/) is a small interface that a center can deploy, customized to their slurm.conf. Since the slurm.conf is readable by all nodes, a user can generate the data for the tool equivalently. 
 - [JobStats](https://github.com/nauhpc/jobstats) makes it easy for users to see status of jobs, and what resources were actually utilized from those requested.
  - [doppler](https://github.com/nauhpc/doppler) is a complementary web application to jobstats that shows users, and account job efficiency/resource wastage.
 - [smanage](https://vsoch.github.io/lessons/smanage/) is a tool developed out of Harvard to help with management of job arrays.

## References

<span id='question-how-do-i-transition-from-sun-grid-engine-to-slurm'></span>

 - [SGE to SLURM Max Planck](https://www.mpcdf.mpg.de/services/computing/linux/migration-from-sge-to-slurm)
 - [SGE to SLURM Converstion from Stanford](https://srcc.stanford.edu/sge-slurm-conversion)
 - [AskCI Site](https://ask.ci)



