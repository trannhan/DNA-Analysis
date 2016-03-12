#!/usr/bin/perl

#USAGE: ./assemble_t.pl
#DESCRIPTION: Print the usage instructions for commands: velveth, velvetg, and oases. 
#Code challenge 5 : https://github.com/NGSAnalysisOnBeocatClass/in_class_problems/blob/master/Lecture5.md#code-challenge-5

use 5.010; # this script requires Perl 5.10 or greater
use strict;
use warnings;

my $fastq1 = '~/class/cell_line_good_1.fastq';
my $fastq2 = '~/class/cell_line_good_2.fastq';
my $assembly_dir = 'out_put/assemble_t_23';

print 'export PATH=/homes/bioinfo/bioinfo_software/velvet:/homes/bioinfo/bioinfo_software/oases:${PATH}';
print "\n";

print "velveth ${assembly_dir} 23 -shortPaired -fastq -separate $fastq1 $fastq2\n"; 
print "velvetg ${assembly_dir} -read_trkg yes\n";
print "oases ${assembly_dir}\n";