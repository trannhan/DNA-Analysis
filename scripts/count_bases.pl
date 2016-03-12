#!/usr/bin/perl

# USAGE: ./count_bases.pl <FASTA_file>
# DESCRIPTION: Display the frequency of appearance of A,C,G,T, and IUPAC.
# Code challenge 7: https://github.com/NGSAnalysisOnBeocatClass/in_class_problems/blob/master/Lecture6.md

use 5.010; # this script requires Perl 5.10 or greater
use strict;
use warnings;

my $fasta = $ARGV[0]; #File to open
my %counts = ('A',0,'C',0,'G',0,'T',0,'IUPAC',0); #Store the frequencies of A,C,G,T, and IUPAC
my @seq;

open FASTA, "<$fasta";

while(<FASTA>)
{
	unless(/^>/)
	{
		chomp;	
		
		@seq = split('',$_); #Get the list of characters from the current line in the file

		#Loop through all the characters and count:
		foreach my $char (@seq)
		{
			if($char eq 'A')
			{
				$counts{'A'}++;
			}
			elsif($char eq 'C')
			{
				$counts{'C'}++;
			}
			elsif($char eq 'G')
			{
				$counts{'G'}++;
			}
			elsif($char eq 'T')
			{
				$counts{'T'}++;
			}
			else
			{
				$counts{'IUPAC'}++;
			}
		}
	}
}
close(FASTA);

foreach (keys %counts)
{
	print "The frequency of $_ in the file is: \t$counts{$_}\n";
}