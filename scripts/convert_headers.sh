#!/bin/bash
# USAGE: ./convert_headers.sh list_of_fastq_files
# DESCRIPTION: Create header for the input fastq files and save in ~/output as BaseNameofInputFile_header.fastq
# Code challenge 4: https://github.com/NGSAnalysisOnBeocatClass/in_class_problems/blob/master/Lecture3.md#code-challenge-4

OUTPUT=~/output
mkdir -p $OUTPUT
echo CREATE HEADER FOR FASTQ FILES AND SAVE IN $OUTPUT.

for FILE in $*
do
	echo ""
	echo --------Working on file $FILE--------:
	
	BASE=$(basename $FILE .fastq)
	echo Basename of the file is: $BASE

	echo Create header for file $BASE.fastq and save as ${BASE}_header.fastq ...
	cat $FILE | awk '{if (NR % 4 == 1) {split($1, arr, ":"); printf "%s_%s:%s:%s:%s:%s#0/%s\n", arr[1], arr[3], arr[4], arr[5], arr[6], arr[7], substr($2, 1, 1), $0} else if (NR % 4 == 3){print "+"} else {print $0} }' > $OUTPUT/${BASE}_header.fastq
done
echo DONE.