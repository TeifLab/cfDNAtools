# cfDNAtools 
Nucleosomics-focused scripts for analysis of cfDNA, nucleosome positioining _in vivo_ and related aspects. This repository hosts few scripts associated with our current manuscripts on nucleosome repositioning in cancer.

**extract_nuc_sizes.pl** - takes as input a [NucTools](https://homeveg.github.io/nuctools/)-compatible BED file with paired-end reads which contains a column with DNA fragment sizes, and extracts to a new BED file only the fragments within a set range of sizes. Example command: 

```perl extract_nuc_sizes.pl -input=<in.bed> -output=<out.bed> -min=<min_fragment_size> -max=<max_fragment_size> --help\n```

**methylationThresholds.pl** - takes as input a [Bismark](https://www.bioinformatics.babraham.ac.uk/projects/bismark/)-compatible BED file with DNA methylation beta-values as a separate column, and extracts to a new BED file only the nucleotides which have methylation levels between two thresholds. Example command: 

```perl methylationThresholds.pl -input=<in.bed> -output=<out.bed> -threshold1=<minimum_methylation> -threshold2=<maximum_methylation>```

**bed2occupancy.v3d.methyl.pl** - takes as input a [Bismark](https://www.bioinformatics.babraham.ac.uk/projects/bismark/)-compatible BED file with DNA methylation beta-values as a separate column, and outputs a [NucTools](https://homeveg.github.io/nuctools/)-compatible "occupancy" file with normalised DNA methylation score per each nucleotide. Example command: 

```perl bed2occupancy.v3d.methyl.pl <chr1.bed> <chr1.occ>```

**fragment_length_histogram.r** - Takes as input a [NucTools](https://homeveg.github.io/nuctools/)-compatible BED file with paired-end reads which contains a column with DNA fragment sizes, and outputs the distribution of fragment lengths in the form of a histogram. Example command: 

```Rscript fragment_length_histogram.r <input_bed_file.bed> <output_file.txt>```
