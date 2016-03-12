
# USAGE:
# DESCRIPTION:
# Weekly problem 3 : https://github.com/NGSAnalysisOnBeocatClass/weekly_problems/blob/master/week3_problems.md

#==============================PROBLEM 1========================================
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
my $current_contig_length;

for(my $j=0;$fraction<$half_total_length;$j++)
{
	$fraction += $lengths[$j];
	$current_contig_length = $lengths[$j];	
}
print "N50 current_contig_length = $current_contig_length\n";

#==============================PROBLEM 2========================================
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
		chomp;
		unless(/^#/)
		{
			my @a = split("\t",$_);

			if($a[2] eq $name)
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