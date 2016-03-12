#!/usr/bin/perl

# USAGE: ./N50.pl <Fasta_file>
# DESCRIPTION: Parsing fasta files to get N50.
# Week3 - Problem 1: https://github.com/NGSAnalysisOnBeocatClass/weekly_problems/blob/master/week3_problems.md

use 5.010; # this script requires Perl 5.10 or greater
use strict;
use warnings;

my @lengths;
my $total_length = 0;
my $l = 0;
my $infile = $ARGV[0]; #File to open

open(IN, "<$infile");
while(<IN>)
{
	if(/^>/  || eof)
	{		
		if($l > 0)
		{
			push @lengths, $l;
			$total_length += $l;
		}
		$l = 0;
	}
	else
	{		
		s/\s//g;		
		$l += length($_);	
	}
}
close(IN);

@lengths = sort{$b<=>$a} @lengths;
print "Total_length = $total_length\n";

my $fraction = 0;
my $half_total_length = $total_length/2;
my $j;

for($j=0;$fraction<$half_total_length;$j++)
{
	$fraction += $lengths[$j];
}

print "N50 current_contig_length = $lengths[$j-1]\n";