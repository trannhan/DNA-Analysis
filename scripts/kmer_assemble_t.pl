#!/usr/bin/perl

# USAGE: ./kmer_assemble_t.pl
# DESCRIPTION: Print the usage instructions for commands: velveth, velvetg, and oases eight times.
# Code challenge 6: https://github.com/NGSAnalysisOnBeocatClass/in_class_problems/blob/master/Lecture5.md

use 5.010; # this script requires Perl 5.10 or greater
use strict;
use warnings;

my $assembly_dir = 'out_put/assemble_t';
my $fastq1 = '~/class/cell_line_good_1.fastq';
my $fastq2 = '~/class/cell_line_good_2.fastq';
my $kmer_length = 100000;


for ( my $k = 25; $k <= 39; $k +=2)
{
	print 'export PATH=/homes/bioinfo/bioinfo_software/velvet:/homes/bioinfo/bioinfo_software/oases:${PATH}';
	print "\n";

	print "velveth ${assembly_dir}_$k $k -shortPaired -fastq -separate $fastq1 $fastq2\n"; 
	print "velvetg ${assembly_dir}_$k -read_trkg yes\n";
	print "oases ${assembly_dir}_$k\n";
}