# cfDNAtools - scripts for analysis of cfDNA, nucleosome positioining and related aspects

**extract_nuc_sizes.pl** - takes as input a [NucTools](https://homeveg.github.io/nuctools/)-compatible BED file with paired-end reads which contains a column with fragment sizes, and extracts to a new BED file the fragments within a set range of sizes. Example command: 

```extract_nuc_sizes.pl -input=<in.bed> -output=<out.bed> -min=<min_fragment_size> -max=<max_fragment_size> --help\n```

**bed2occupancy.v3d.methyl.pl** - takes as input a [Bismark](https://www.bioinformatics.babraham.ac.uk/projects/bismark/)-compatible BED file with DNA methylation beta-values as a separate column, and outputs a [NucTools](https://homeveg.github.io/nuctools/)-compatible "occupancy" file with normalised DNA methylation score per each nucleotide. 

