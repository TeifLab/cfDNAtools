# cfDNAtools - scripts for cfDNA processing

**extract_nuc_sizes.pl** - takes as input NucTools-compatible BED file format with an additional column that contains fragment size, and extracts to a new BED file only fragments within a set range of sizes. Example command: 

```extract_nuc_sizes.pl -input=<in.bed> -output=<out.bed> -min=<min_fragment_size> -max=<max_fragment_size> --help\n```
