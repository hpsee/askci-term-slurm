# slurm

## How do i transition from sun grid engine to slurm?

<table><tbody><tr><td><strong>User Commands</strong></td>
			<td><strong>SGE</strong></td>
			<td><strong>SLURM</strong></td>
		</tr><tr><td><strong>Interactive login</strong></td>
			<td>qlogin</td>
			<td>
				<pre>
srun --pty bash or srun (-p "partition name"--time=4:0:0 --pty bash For a quick dev node, just run "sdev"</pre>
			</td>
		</tr><tr><td><strong>Job submission</strong></td>
			<td>qsub [script_file]</td>
			<td>sbatch [script_file]</td>
		</tr><tr><td><strong>Job deletion</strong></td>
			<td>qdel [job_id]</td>
			<td>scancel [job_id]</td>
		</tr><tr><td><strong>Job status by job</strong></td>
			<td>qstat -u \* [-j job_id]</td>
			<td>squeue [job_id]</td>
		</tr><tr><td><strong>Job status by user</strong></td>
			<td>qstat [-u user_name]</td>
			<td>
				<p>squeue -u [user_name]</p>
			</td>
		</tr><tr><td><strong>Job hold</strong></td>
			<td>qhold [job_id]</td>
			<td>scontrol hold [job_id]</td>
		</tr><tr><td><strong>Job release</strong></td>
			<td>qrls [job_id]</td>
			<td>scontrol release [job_id]</td>
		</tr><tr><td><strong>Queue list</strong></td>
			<td>qconf -sql</td>
			<td>squeue</td>
		</tr><tr><td><strong>List nodes</strong></td>
			<td>qhost</td>
			<td>sinfo -N OR scontrol show nodes</td>
		</tr><tr><td><strong>Cluster status</strong></td>
			<td>qhost -q</td>
			<td>sinfo</td>
		</tr><tr><td><a href="http://slurm.schedmd.com/sview.html" rel="nofollow"><strong>GUI</strong></a></td>
			<td>qmon</td>
			<td>sview</td>
		</tr><tr><td> </td>
			<td> </td>
			<td> </td>
		</tr><tr><td><strong>Environmental</strong></td>
			<td> </td>
			<td> </td>
		</tr><tr><td><strong>Job ID</strong></td>
			<td>$JOB_ID</td>
			<td>$SLURM_JOBID</td>
		</tr><tr><td><strong>Submit directory</strong></td>
			<td>$SGE_O_WORKDIR</td>
			<td>$SLURM_SUBMIT_DIR</td>
		</tr><tr><td><strong>Submit host</strong></td>
			<td>$SGE_O_HOST</td>
			<td>$SLURM_SUBMIT_HOST</td>
		</tr><tr><td><strong>Node list</strong></td>
			<td>$PE_HOSTFILE</td>
			<td>$SLURM_JOB_NODELIST</td>
		</tr><tr><td><strong>Job Array Index</strong></td>
			<td>$SGE_TASK_ID</td>
			<td>$SLURM_ARRAY_TASK_ID</td>
		</tr><tr><td> </td>
			<td> </td>
			<td> </td>
		</tr><tr><td><strong>Job Specification</strong></td>
			<td> </td>
			<td> </td>
		</tr><tr><td><strong>Script directive</strong></td>
			<td>#$</td>
			<td>#SBATCH</td>
		</tr><tr><td><strong>queue</strong></td>
			<td>-q [queue]</td>
			<td>-p [queue]</td>
		</tr><tr><td><strong>count of nodes</strong></td>
			<td>N/A</td>
			<td>-N [min[-max]]</td>
		</tr><tr><td><strong>CPU count</strong></td>
			<td>-pe [PE] [count]</td>
			<td>-n [count]</td>
		</tr><tr><td><strong>Wall clock limit</strong></td>
			<td>-l h_rt=[seconds]</td>
			<td>-t [min] OR -t [days-hh:mm:ss]</td>
		</tr><tr><td><strong>Standard out file</strong></td>
			<td>-o [file_name]</td>
			<td>-o [file_name]</td>
		</tr><tr><td><strong>Standard error file</strong></td>
			<td>-e [file_name]</td>
			<td>e [file_name]</td>
		</tr><tr><td><strong>Combine STDOUT &amp; STDERR files </strong></td>
			<td>-j yes</td>
			<td>(use -o without -e)</td>
		</tr><tr><td><strong>Copy environment</strong></td>
			<td>-V</td>
			<td>--export=[ALL | NONE | variables]</td>
		</tr><tr><td><strong>Event notification</strong></td>
			<td>-m abe</td>
			<td>--mail-type=[events]</td>
		</tr><tr><td><strong>send notification email</strong></td>
			<td>-M [address]</td>
			<td>--mail-user=[address]</td>
		</tr><tr><td><strong>Job name</strong></td>
			<td>-N [name]</td>
			<td>--job-name=[name]</td>
		</tr><tr><td><strong>Restart job</strong></td>
			<td>-r [yes|no]</td>
			<td>--requeue OR --no-requeue (NOTE:<br />
				configurable default)</td>
		</tr><tr><td><strong>Set working directory</strong></td>
			<td>-wd [directory]</td>
			<td>--workdir=[dir_name]</td>
		</tr><tr><td><strong>Resource sharing</strong></td>
			<td>-l exclusive</td>
			<td>--exclusive OR--shared</td>
		</tr><tr><td><strong>Memory size</strong></td>
			<td>-l mem_free=[memory][K|M|G]</td>
			<td>--mem=[mem][M|G|T] OR --mem-per-cpu=<br />
				[mem][M|G|T]</td>
		</tr><tr><td><strong>Charge to an account</strong></td>
			<td>-A [account]</td>
			<td>--account=[account]</td>
		</tr><tr><td><strong>Tasks per node</strong></td>
			<td>(Fixed allocation_rule in PE)</td>
			<td>--tasks-per-node=[count]</td>
		</tr><tr><td> </td>
			<td> </td>
			<td>--cpus-per-task=[count]</td>
		</tr><tr><td><strong>Job dependency</strong></td>
			<td>-hold_jid [job_id | job_name]</td>
			<td>--depend=[state:job_id]</td>
		</tr><tr><td><strong>Job project</strong></td>
			<td>-P [name]</td>
			<td>--wckey=[name]</td>
		</tr><tr><td><strong>Job host preference</strong></td>
			<td>-q [queue]@[node] OR -q<br />
				[queue]@@[hostgroup]</td>
			<td>--nodelist=[nodes] AND/OR --exclude=<br />
				[nodes]</td>
		</tr><tr><td><strong>Quality of service</strong></td>
			<td> </td>
			<td>--qos=[name]</td>
		</tr><tr><td><strong>Job arrays</strong></td>
			<td>-t [array_spec]</td>
			<td>--array=[array_spec] (Slurm version 2.6+)</td>
		</tr><tr><td><strong>Generic Resources</strong></td>
			<td>-l [resource]=[value]</td>
			<td>--gres=[resource_spec]</td>
		</tr><tr><td><strong>Lincenses</strong></td>
			<td>-l [license]=[count]</td>
			<td>--licenses=[license_spec]</td>
		</tr><tr><td><strong>Begin Time</strong></td>
			<td>-a [YYMMDDhhmm]</td>
			<td>--begin=YYYY-MM-DD[THH:MM[:SS]]</td>
		</tr></tbody></table><p> </p>
<table><tbody><tr><th>SGE</th>
			<th>SLURM</th>
		</tr></tbody><tbody><tr><td>qstat<br /><blockquote>qstat -u username<br />
					qstat -f</blockquote>
			</td>
			<td>squeue<br /><blockquote>squeue -u username<br />
					squeue -al</blockquote>
			</td>
		</tr><tr><td>qsub<br /><blockquote>qsub -N jobname<br />
					qsub -l h_rt=24:00:00<br />
					qsub -pe dmp4 16<br />
					qsub -l mem=4G<br />
					qsub -o filename<br />
					qsub -e filename<br />
					qsub -l scratch_free=20G</blockquote>
			</td>
			<td>sbatch<br /><blockquote>sbatch -J jobname<br />
					sbatch -t 24:00:00<br />
					sbatch -p node -n 16</blockquote>
				<blockquote>sbatch --mem=4000<br />
					sbatch -o filename<br />
					sbatch -e filename</blockquote>
			</td>
		</tr><tr><td># Interactive run, one core</td>
			<td># Interactive run, one core</td>
		</tr><tr><td>qrsh -l h_rt=8:00:00</td>
			<td>salloc -t 8:00:00<br />
				interactive -p core -n 1 -t 8:00:00</td>
		</tr><tr><td><br />
				qdel</td>
			<td><br />
				scancel</td>
		</tr></tbody></table>


### Examples

What Jobs are currently running?
```bash
#SGE
qstat -u username

#SLURM
squeue -u username
```

### Bash Script Examples:

### SGE

```bash
#!/bin/bash -l 

#$ -N test
#$ -j y
#$ -o test.output
#$ -cwd
#$ -M $email@address.edu
#$ -m ea
# Request 5 hours run time
#$ -l h_rt=5:0:0
#$ -P your_project_id_here
#
#$ -l mem=4G
# 
 
module load python/3.6.2
python my_script.py
```

### slurm

```bash
#!/bin/bash -l
# NOTE the -l flag!

#SBATCH -J test
#SBATCH -o test."%j".out
#SBATCH -e test."%j".err
# Default in slurm
#SBATCH --mail-user $email@address.edu
#SBATCH --mail-type=ALL
# Request 5 hours run time
#SBATCH -t 5:0:0
#SBATCH --mem=4000
#SBATCH -p normal
 
module load python/3.6.2
python my_script.py
```


## References

<span id='question-how-do-i-transition-from-sun-grid-engine-to-slurm'></span>


 - [SGE to SLURM Max Planck](https://www.mpcdf.mpg.de/services/computing/linux/migration-from-sge-to-slurm)
 - [SGE to SLURM Converstion from Stanford](https://srcc.stanford.edu/sge-slurm-conversion)
 - [AskCI Site](https://ask.ci)


