#!/bin/bash
#########################################################################
# For weekly problems you should download the the weekly problem text file from KSOL (in this case "week1_problems.txt") . Open it in TextWrangler or Notepad++. Record your code for each step below the comment lines that begin with "#Run your own command..." and save your file when you are done. You will also need to run these commands on Beocat. By the end of the exercise all of your output should be in the "~/hw1" directory that you created. At the start of class Monday we will make these directories readable so that instructors can review the output of your commands. 
# 
# When you are done editing your code save your text file and click Begin Assignment to upload your completed assignment to KSOL.
#########################################################################

# USAGE: ./hw3.sh
# DESCRIPTION: Indexing Ecoli genome


#Run your own command to create a directory named `hw1` in your home directory.
mkdir -p hw1
cd hw1


#Run your own command using wget to download the genome fasta file to your ~/hw1 directory
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Bacteria/Escherichia_coli_K_12_substr__MG1655_uid57779/NC_000913.fna


#Run your own command using wget to download the .sra file to your ~/hw1 directory
wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/SRR136/SRR1363869/SRR1363869.sra


#Run your own command using fastq-dump to download the .sra file to your ~/hw1 directory
/homes/bioinfo/bioinfo_software/sratoolkit.2.3.5-ubuntu64/bin/fastq-dump --split-3 ~/hw1/SRR1363869.sra


#Run your own command using prinseq-lite.pl to quality check your reads
perl /homes/bioinfo/bioinfo_software/prinseq-lite.pl -verbose -fastq ~/hw1/SRR1363869.fastq -graph_data -out_good null -out_bad null


#Run your own commands to generate read quality graphs in your ~/hw1 directory
perl /homes/bioinfo/bioinfo_software/prinseq-graphs.pl -verbose -i ~/hw1/SRR1363869.fastq.gd -html_all


#Run your own command to generate an index of your fasta genome in your ~/hw1 directory
/homes/bioinfo/bioinfo_software/bowtie2-2.1.0/bowtie2-build ~/hw1/NC_000913.fna ~/hw1/NC_000913


#Run your own command to generate a SAM file of the sampled fastq reads aligned to your indexed genome in your ~/hw1 directory
/homes/bioinfo/bioinfo_software/bowtie2-2.1.0/bowtie2  -q -x ~/hw1/NC_000913 -U ~/hw1/SRR1363869.fastq -S ~/hw1/SRR1363869.sam


#Run your own piped command that completes all four steps above to generate a flagstat summary of your alignments (type piped command and the output of flagstat below)
/homes/bioinfo/bioinfo_software/samtools/samtools view -Sb ~/hw1/SRR1363869.sam | /homes/bioinfo/bioinfo_software/samtools/samtools sort -o - - | /homes/bioinfo/bioinfo_software/samtools/samtools rmdup - - | /homes/bioinfo/bioinfo_software/samtools/samtools flagstat -
