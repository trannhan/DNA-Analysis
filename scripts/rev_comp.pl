#!/usr/bin/perl

# USAGE: ./rev_comp.pl <FASTA_file>
# DESCRIPTION: Print the reverse complement of DNAs. 
# https://github.com/NGSAnalysisOnBeocatClass/homework/blob/master/homework_6.md

use 5.010; # this script requires Perl 5.10 or greater
use strict;
use warnings;
use File::Basename; # enable maipulating of the full path

system(`mkdir -p output`); #Create output folder

my $file = $ARGV[0]; 
my ($basename, $directories, $suffix) = fileparse($file,'\..*'); # break appart filenames
my $outfile = "output/${basename}_revcomp${suffix}";
my $current_contig;
my $s;


open(OUT,">$outfile");

open(IN,"<$file");
while(<IN>)
{
	if((/^>/))
	{
		if($current_contig)
		{
			$s = &reverse_comp($current_contig);
			print OUT "$s\n"; #write the sequence to the output file
			$current_contig = '';
		}
		print OUT $_; #write the header to output file
	}
	elsif(!/^>/ && !eof)
	{
		chomp;
		$current_contig .= $_; #concatinate the sequence
	}
	elsif(eof)
	{	
		$s = &reverse_comp($current_contig);
		print OUT "$s\n";
	}
}
close(IN);

close(OUT);

#Get a DNA sequence and produce the reversed complement sequence
sub reverse_comp
{
	my %nu = ('A','T','C','G','G','C','T','A','a','t','c','g','g','c','t','a');
	my $contig = $_[0];
	my $new_contig = '';
	my @seq = split('',$contig);

	@seq = reverse @seq;
	foreach my $char (@seq)
	{
		if($nu{$char})
		{
			$new_contig .= $nu{$char};
		}
		else
		{
			$new_contig .= $char;
		} 
	}
	return $new_contig;
}