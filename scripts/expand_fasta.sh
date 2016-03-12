
# USAGE: ./expand_fasta.sh list_of_zip_files
# DESCRIPTION: Unzip the input zip files and put in ~/output using the base name of the files
# Code challenge 3: https://github.com/NGSAnalysisOnBeocatClass/in_class_problems/blob/master/Lecture3.md

OUTPUT=~/output
mkdir -p $OUTPUT
echo UNZIP THE COMPRESSED FASTA FILES AND SAVE IN $OUTPUT.

for FILE in $*
do
	echo ""
	echo --------Working on file $FILE--------:
	
	BASE=$(basename $FILE .gz)
	echo Basename of the file is: $BASE

	echo Unzip the file $BASE.gz ...
	gunzip -c $FILE > $OUTPUT/$BASE

	echo The number of Fasta sequences in $BASE is:
        COUNT=$(grep -c ">" $OUTPUT/$BASE)
	echo $COUNT
done