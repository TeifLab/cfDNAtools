# cfDNAtools - scripts for cfDNA processing

**extract_nuc_sizes.pl** - takes as input [NucTools](https://homeveg.github.io/nuctools/)-compatible BED file with paired-end reads which contains a column with fragment sizes, and extracts to a new BED file the fragments within a set range of sizes. Example command: 

```extract_nuc_sizes.pl -input=<in.bed> -output=<out.bed> -min=<min_fragment_size> -max=<max_fragment_size> --help\n```
