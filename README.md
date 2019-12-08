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


## References

<span id='question-how-do-i-transition-from-sun-grid-engine-to-slurm'></span>


 - [SGE to SLURM Max Planck](https://www.mpcdf.mpg.de/services/computing/linux/migration-from-sge-to-slurm)
 - [SGE to SLURM Converstion from Stanford](https://srcc.stanford.edu/sge-slurm-conversion)
 - [AskCI Site](https://ask.ci)

