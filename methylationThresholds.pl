#!/usr/bin/perl -w

use strict "vars";

my $usage = "$0 -input=<in.bed> -output=<out.bed> -threshold1=<> -threshold2=<> --verbose\n";

my $infile;
my $outfile;
my $columns = 0;
my $threshold1 = 0;
my $threshold2 = 1;
my $verbose_flag = 0;


#read arguments from command line
if (@ARGV != 0) {
    foreach my $comand_line_flag (@ARGV) {
	if ($comand_line_flag =~ /-input=(.*)/i) { $infile = $1; }
	if ($comand_line_flag =~ /-output=(.*)/i) { $outfile = $1; }
	if ($comand_line_flag =~ /-threshold1=(.*)/i) { $threshold1 = $1; }
	if ($comand_line_flag =~ /-threshold2=(.*)/i) { $threshold2 = $1; }
	if ($comand_line_flag =~ /--verbose/i) { $verbose_flag = 1; }
    }
}
else {
    print STDERR $usage,"\n"; exit;
}

print STDERR "======================\n";
print STDERR "Infile: $infile\n";
print STDERR "Outfile: $outfile\n";
print STDERR "======================\n\n";


open(IN, $infile) or die "error: $infile cannot be opened: $!\n";
my $buffer = "";
my $sz_buffer = 0;
my $timer2 = time();

# counter for the markers we see
my $filesize_in_bytes = -s $infile; #determine file size in bytes
my $filesize = int($filesize_in_bytes/(1024)); # filesize in megabytes
print STDERR "Reading $infile file of $filesize KBs. Please wait...\n"; 
my $processed_memory_size = 0;
my $offset=0;
my $not_zero_counter=0;
my $string_counter=0;
my $saved_string_counter=0;
my $BUFFER_SIZE = 1024;
my @origin; # to keep source data
my @occup;
my $old_coordinate=1;
open(OUT, ">$outfile") || die "Can't open $outfile for writing: $!\n";
while ((my $n = read(IN, $buffer, $BUFFER_SIZE)) !=0) {
    if (($n >= $BUFFER_SIZE) or (($n == $filesize_in_bytes))) {
        $buffer .= <IN>;
    }
    my @lines = split(/\n/, $buffer);
    # process each line in zone file
    foreach my $line (@lines) {
        chomp($line);
        my @array=split(/\t/, $line);
        #old string:  chr, coord, methyl1, methyl2, SNP.
        my $chr = $array[0];
        my $reg_coord = $array[1];
	 my $reg_coord2 = $array[2];
        my $methyl1 = $array[4];
        my $methyl2 = $array[4];
        my $SNP = $array[3];
        my $ratio=$array[3];

#	if ($methyl2 == 0) { $ratio=0;  }
#	else {$ratio=$methyl1/$methyl2; }

        # new string:  chr, coord, coord, methyl1, methyl2, SNP, methyl1/methyl2
	
        if ($ratio >= $threshold1 && $ratio <= $threshold2) {
	    print OUT join("\t", $chr, $reg_coord, $reg_coord, $ratio ), "\n";
	    
	    if ($verbose_flag == 1) {
		print STDERR join("\t", $chr, $reg_coord, $reg_coord, $ratio), "\n";
	    }
	    
	    $saved_string_counter++;
	}
	$string_counter++;

    }
    $processed_memory_size += $n;
    $offset += $n;
    if ($verbose_flag == 0) {
	if(int($processed_memory_size/(1024))>= $filesize/10) {
	    print STDERR int($offset/(1024)), " KBs processed in ", time()-$timer2, " seconds.\n";
	    $processed_memory_size=0;
	    #last;
	    }
    }
    undef @lines;
    $buffer = "";
}
close(IN);
close(OUT);
print STDERR "done!$saved_string_counter strings from $string_counter saved\n\n";
exit;