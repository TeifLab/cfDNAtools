#/local/bin/perl
###
### extract_nuc_sizes.pl
### version: v4
###
#################################

use strict "vars";
my $usage = "$0 -input=<in.bed> -output=<out.bed> -min=<min_fragment> -max=<max_fragment> --help\n";
my $infile;
my $outfile;
my $min_fragment;
my $max_fragment;

if (@ARGV != 0) {
    foreach my $comand_line_flag (@ARGV) {
	if ($comand_line_flag =~ /-input=(.*)/i) { $infile = $1; }
	if ($comand_line_flag =~ /-output=(.*)/i) { $outfile = $1;}
	if ($comand_line_flag =~ /-min=(\d*)/i) { $min_fragment = $1;}
	if ($comand_line_flag =~ /-max=(\d*)/i) { $max_fragment = $1;}
        
	if ($comand_line_flag =~ /--help/i) {
	    print STDOUT <DATA>;
	    print STDOUT "\nPress <ENTER> button to exit... ";
	    <STDIN>;
	    exit;
	}
    }
}
else { warn "$usage"; exit;}

open(OUT, ">$outfile") || die "error: can't open $outfile for writing!\n";
open(IN, $infile) or die "error: $infile cannot be opened: $!\n";

print  "min_fragment=", $min_fragment, "\n";
print  "max_fragment=", $max_fragment, "\n";

my $buffer = "";
my $sz_buffer = 0;
my $timer2 = time();
# counter for the markers we see
my $marker_count = 0;

my $regex_split_newline='\n';

my $filesize_in_bytes = -s $infile; #determine file size in bytes
my $size_counter_step=int($filesize_in_bytes/100);
my $filesize = int($filesize_in_bytes/1048576); # filesize in megabytes

print STDERR "Reading $infile file of $filesize MBs. Please wait...\n";
my $processed_memory_size = 0;
my $offset=0;
my $BUFFER_SIZE = 1024;
my $old_coordinate=1;
my $counter=0;


while ((my $n = read(IN, $buffer, $BUFFER_SIZE)) !=0) {
    if (($n >= $BUFFER_SIZE) or (($n == $filesize_in_bytes))) {
        $buffer .= <IN>;
    }
    my @lines = split(/$regex_split_newline/o, $buffer);
    # process each line in zone file
    foreach my $line (@lines) {
        chomp($line);
        my @newline=split(/\t/, $line);

        #print "newline[3]=", $newline[3], "newline[3]-min_fragment=", $newline[3]-$min_fragment, "newline[3]-max_fragment=", $newline[3]-$max_fragment, "\n";

        if (($newline[3] >= $min_fragment) and ($newline[3] <= $max_fragment)) 
        #if (($newline[3] >= 0) and ($newline[3] < 1e10))
        {
          print OUT join("\t",@newline), "\n";
          $counter++;
        }
    }
    $processed_memory_size += $n;
    $offset += $n;
    if(int($processed_memory_size/1048576)>= $filesize/100) {
        print STDERR int($offset/1048576), " Mbs processed in ", time()-$timer2, " seconds.\n"; $processed_memory_size=0;
        #last;
        }
    undef @lines;
    $buffer = "";
}
close(IN);
close(OUT);

print  "counter=", $counter, "\n";

print STDERR "done!\nJob finished in ", time()-$timer2, " seconds.\n";
exit;


__DATA__
==================================================================================================
### Extracts DNA fragments with certain sizes
==================================================================================================

perl -w extract_rows_occup.pl -input=<in.bed> -output=<out.bed> -min=<min_fragment> -stop=<max_fragment> --help

-input=<input *.bed file>
-output=<output *.bed file containing only selected region>
-strat=<selected min_fragment>
-max=<selected max_fragment>
