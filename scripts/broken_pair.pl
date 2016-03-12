#!/usr/bin/perl

# USAGE: ./broken_pair.pl <Forward_FASTQ_file> <Reverse_FASTQ_file>
# DESCRIPTION: Fix broken pairs in FASTQ file. If pair order is violated then correct the order and remove "broken pairs". Broken pairs are reads that no longer have a pair in one of the two input FASTQ files. These are moved to a file with "singletons" in the name under output folder.
# https://github.com/NGSAnalysisOnBeocatClass/weekly_problems/blob/master/week4_problems.md

use 5.010; # this script requires Perl 5.10 or greater
use strict;
use warnings;
use File::Basename; # enable maipulating of the full path

my $infile1 = $ARGV[0]; 
my $infile2 = $ARGV[1]; 
my $IN1;
my $IN2;

system(`mkdir -p output`); #Create output folder

my ($basename, $directories, $suffix) = fileparse($infile1,'\..*'); # break appart filenames
my $outfile1 = "output/${basename}_good${suffix}"; #Create output filenames with that begin with the directory output/ and has _good added to the basename

($basename, $directories, $suffix) = fileparse($infile2,'\..*'); # break appart filenames
my $outfile2 = "output/${basename}_good${suffix}"; #Create output filenames with that begin with the directory output/ and has _good added to the basename

my $outfile3 = "output/${basename}1_singletons${suffix}"; #Create an output filename that begins with the directory output/ and includes the basename of one input file, the number (1 or 2) of the other and _singletons

#Open input files to read:
open($IN1,"<", "$infile1");
open($IN2,"<", "$infile2");

#Open output files to write:
open(OUT1,">$outfile1");
open(OUT2,">$outfile2");
open(OUT3,">$outfile3");

my $header;
my $next_line;
my %hash1; #for forward reads
my %hash2; #for reverse reads
my $order;


#Make a hash of forward reads:
# While there are lines in the forward read file:
#-- Make a key in the hash for the header without \1\n
#-- Make the value be the text that was removed from the header: \1\n
#-- Append the next three lines after the header to the end of the value in the hash.
$order = "\\1\n";
while(<$IN1>)
{
	if(/@/)
	{
		$header = &conserved_header($_);
	}
	else
	{
		$next_line = concat_3lines($IN1,$_);
		$next_line = $order.$next_line;
		$hash1{$header} = $next_line;
	}

}

#Make a hash of reverse reads:
# While there are lines in the reverse read file:
#-- Make a key in the hash for the header without \2\n
#-- Make the value be the text that was removed from the header: \2\n
#-- Append the next three lines after the header to the end of the value in the hash.
$order = "\\2\n";
while(<$IN2>)
{
	if(/@/)
	{
		$header = &conserved_header($_);
	}
	else
	{
		$next_line = concat_3lines($IN2,$_);
		$next_line = $order.$next_line;
		$hash2{$header} = $next_line;
	}

}


#If a key exists in both hashes print both keys and values to their respective forward or reverse output read files and delete the keys and values from the hashes
foreach my $key (keys %hash1)
{
	if(exists $hash2{$key})
	{
		print OUT1 $key;
		print OUT1 $hash1{$key};
		delete $hash1{$key};

		print OUT2 $key;
		print OUT2 $hash2{$key};
		delete $hash2{$key};
	}
}

#If not print the reverse key and value to the singleton output read file and delete the key and value from the reverse read hash
foreach my $key (keys %hash2)
{
	print OUT3 $key;
	print OUT3 $hash2{$key};
	delete $hash2{$key};
}

#For any remaining key in the forward hash: print the forward key and value to the singleton output read file
foreach my $key (keys %hash1)
{
	print OUT3 $key;
	print OUT3 $hash1{$key};
	delete $hash1{$key};
}

#Close all the opening files:
close($IN1);
close($IN2);
close(OUT1);
close(OUT2);
close(OUT3);


#Get conserved portion of header
sub conserved_header
{
	my $header_line = $_[0];
	if($header_line =~ /\//)
	{
		return $`;
	}
}


#Conatenate three lines after a header 
sub concat_3lines
{
	my $fh = shift @_;
	my $next_lines = shift @_;

	$next_lines .= <$fh>;
	$next_lines .= <$fh>;

	return $next_lines;
}



















