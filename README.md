# cfDNAtools 
Nucleosomics-focused scripts for analysis of cfDNA, nucleosome positioining _in vivo_ and related aspects. This repository currently hosts few minimally-annotated scripts associated with our current manuscripts and will be upgraded later with a more detailed description and wider variety of nucleosomics-related scripts.

**extract_nuc_sizes.pl** - takes as input a [NucTools](https://homeveg.github.io/nuctools/)-compatible BED file with paired-end reads which contains a column with DNA fragment sizes, and extracts to a new BED file only the fragments within a set range of sizes. Example command: 

```extract_nuc_sizes.pl -input=<in.bed> -output=<out.bed> -min=<min_fragment_size> -max=<max_fragment_size> --help\n```

**methylationThresholds.pl** - takes as input a [Bismark](https://www.bioinformatics.babraham.ac.uk/projects/bismark/)-compatible BED file with DNA methylation beta-values as a separate column, and extracts to a new BED file only the nucleotides which have methylation levels between two thresholds. Example command: 

```methylationThresholds.pl -input=<in.bed> -output=<out.bed> -threshold1=<> -threshold2=<> --verbose```

**bed2occupancy.v3d.methyl.pl** - takes as input a [Bismark](https://www.bioinformatics.babraham.ac.uk/projects/bismark/)-compatible BED file with DNA methylation beta-values as a separate column, and outputs a [NucTools](https://homeveg.github.io/nuctools/)-compatible "occupancy" file with normalised DNA methylation score per each nucleotide. 

