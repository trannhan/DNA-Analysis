#!/usr/bin/perl

# USAGE: ./average_gff3.pl <GFF3_file>
# DESCRIPTION: Parse a GFF3 file to get the average length of features in the GFF3 article describing some genome.
# Week3 - Problem 2: https://github.com/NGSAnalysisOnBeocatClass/weekly_problems/blob/master/week3_problems.md

use 5.010; # this script requires Perl 5.10 or greater
use strict;
use warnings;

my $infile = $ARGV[0]; #File to open
my $name;

$name = "gene";
print "Average of $name is: ", &average($name,$infile), "\n";

$name = "CDS";
print "Average of $name is: ", &average($name,$infile), "\n";

$name = "three_prime_UTR";
print "Average of $name is: ", &average($name,$infile), "\n";

$name = "five_prime_UTR";
print "Average of $name is: ", &average($name,$infile), "\n";



sub average
{
	my $sum = 0;
	my $count = 0;
	my $avg = 0;
	my $name = shift @_;
	my $infile = shift @_;

	open(IN, "<$infile");

	while(<IN>)
	{
		unless(/^#/)
		{
			my @a = split(/\t/,$_);
			#print "@a\n";
			if($a[2] =~ m/$name/)
			{
				$sum += $a[4]-$a[3]+1;
				$count++;
			}
		}		
	}
	if($count != 0)
	{
		$avg = $sum/$count;
	}
	else
	{
		$avg = 0;
	}

	close(IN);

	return $avg;
}