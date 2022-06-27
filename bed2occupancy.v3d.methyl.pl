#/local/bin/perl

use strict "vars";
my $usage = "$0 <in.bed> <out.bed>\n";
my $infile = shift || die $usage;
my $outfile = shift || die $usage;

open(IN, $infile) || die "Can't open $infile for reading!\n";
open(OUT, ">$outfile") || die "Can't open $outfile for writing!\n";

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
my $not_zero_counter=0;
my $string_counter=0;
my $BUFFER_SIZE = 1024;
my @occup=();
my $old_coordinate=1;
while ((my $n = read(IN, $buffer, $BUFFER_SIZE)) !=0) {
    if (($n >= $BUFFER_SIZE) or (($n == $filesize_in_bytes))) {
        $buffer .= <IN>;
    }
    my @lines = split(/$regex_split_newline/o, $buffer);
    # process each line in zone file
    foreach my $line (@lines) {
        chomp($line);
        my @newline1=split(/\t/, $line);
        my $chr_name=$newline1[0];
        my $start_nuc=$newline1[1];
        my $end_nuc=$newline1[2];
	 # 	 my $methylation=$newline1[3]/($newline1[3]+0.0001);
	 my $methylation=$newline1[3];
        my $nuc_length=$end_nuc-$start_nuc;
        my $occup_counter = $occup[$end_nuc];
        if(!$occup_counter) {
            $occup[$end_nuc]=0;
        }
         for (my $j=$start_nuc; $j<=$end_nuc; $j++) {
	     if($methylation >= 0) {
            	if(!$occup[$j]) {$occup[$j]=0;}
            	$occup[$j]+=$methylation;
            }
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

print STDERR "saving occupancy data...";
open(OUT, ">$outfile") || die "Can't open $outfile for writing: $!\n";
for (my $i=0; $i<=$#occup; $i++) {
    print OUT join ("\t", $i,$occup[$i]),"\n";
}
close(OUT);
print STDERR "done!\nJob finished in ", time()-$timer2, " seconds.\n";
exit;
