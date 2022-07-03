args = commandArgs(trailingOnly=TRUE);
file_in=args[1]
file_out=args[2]
library(readr) #you may need to install this with 'install.packages('readr')'
nucs=read_delim(file_in, delim="\t", col_names=F)
colnames(nucs)=c("chr", "start", "end", "frag_length")
h=hist(nucs$frag_length, breaks=200, plot=F) #change the number of bins with the 'breaks' parameter
dataoi=cbind(h$breaks, c(h$counts, NA), c(h$density, NA))
colnames(dataoi)=c("Breaks", "Counts", "Density")
write.table(dataoi, file_out, sep="\t", row.names=F) #writes the histogram data to a text file
png("histogram.png")
plot(dataoi[,1],dataoi[,2],type='l',xlab='frag_lengths',ylab='Frequency')
dev.off()
