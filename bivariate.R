# This script is called from the command line as: Rscript bivariate.R $REFDAT $LOCFILE $INFOFILE $OVERLAPFILE "$PHEN1;$PHEN2" $OUTNAME
# with bash variables representing those described below: 
arg = commandArgs(T)
refdat = arg[1]		# reference data prefix
locfile = arg[2] 	# locus file name
infofile = arg[3]	# input info file name
overlapfile = arg[4]	# sample overlap file
phenos = unlist(strsplit(arg[5],";")) # phenotype IDs separated by ';' (e.g. "depression;bmi")
outname = arg[6] 	# output filename

library(LAVA)

# set univ threshols
univ.thresh = .05 / 2495

# read in locus file
loci = read.loci(locfile)
n.loc = nrow(loci)

# process input
input = process.input(infofile, overlapfile, refdat, phenos)

print(paste("Starting LAVA analysis for",n.loc,"loci"))
progress = ceiling(quantile(1:n.loc, seq(.05,1,.05)))   # (if you want to print the progress)

u = b = list()
for (i in 1:n.loc) {
	if (i %in% progress) print(paste("..",names(progress[which(progress==i)])))  # print progress

	# process locus
	locus = process.locus(loci[i,], input)

	if (!is.null(locus)) {
		# extract locus info
		loc.info = data.frame(locus = locus$id, chr = locus$chr, start = locus$start, stop = locus$stop, n.snps = locus$n.snps, n.pcs = locus$K)

		# run univ & bivar analyses
		out = run.univ.bivar(locus, univ.thresh=univ.thresh)

		# store univ
		u[[i]] = cbind(loc.info, out$univ)

		# store bivar
		if (!is.null(out$bivar)) {
			b[[i]] = cbind(loc.info, out$bivar)
		}
	}
}

write.table(do.call(rbind, u), paste0(outname,".univ"), row.names=F, quote=F)
write.table(do.call(rbind, b), paste0(outname,".bivar"), row.names=F, quote=F)

