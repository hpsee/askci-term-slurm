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


