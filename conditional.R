library(LAVA)

# set input filenames (adapt as necessary)
ref.prefix = "g1000_eur.maf005"  # reference data (MAF > .5)
input.info = "input.info.txt"
sample.overlap = "sample.overlap.dat"

# read in locus file
loci = read.loci("locfile.txt") # (adapt as necessary)


##########################################################################
####################  W H R  ~  T D I  |  B M I  #########################
##########################################################################
# to what extent can the rg between WHR-T2D be accounted for by BMI? (and vice versa)

# process input & relevant locus
input = process.input(input.info, sample.overlap, ref.prefix, phenos=c("T2D","whr","bmi"))
locus = process.locus(subset(loci, LOC==2135), input)

# bivariate cors
run.bivar(locus, target="T2D")

# partial correlation
run.pcor(locus, phenos=c("T2D","whr","bmi")) # T2D ~ WHR | BMI
run.pcor(locus, phenos=c("T2D","bmi","whr")) # T2D ~ BMI | WHR

# multiple regression with BMI as outcome
run.multireg(locus, phenos=c("bmi","whr","T2D"))[[1]][[1]]



###########################################################################
################  C A D  ~  H D L  |  L D L  ##############################
###########################################################################
# to what extent can the rg between CAD-T2D be accounted for by BMI? (and vice versa)

# process input & relevant locus
input = process.input(input.info, sample.overlap, ref.prefix, phenos=c("HDL","LDL","cad"))
locus = process.locus(subset(loci, LOC==2351), input)

# bivar
run.bivar(locus, target="cad")

# partial cor
run.pcor(locus, phenos=c("cad","LDL","HDL")) # CAD ~ LDL | HDL
run.pcor(locus, phenos=c("cad","HDL","LDL")) # CAD ~ HDL | LDL

# multiple regression with CAD as outcome
run.multireg(locus, phenos=c("LDL","HDL","cad"))




##########################################################################
####################   H Y P E R T E N S I O N   #########################
##########################################################################
# Multiple regressions with hypertension as outcome and T2D, WHR, & BMI as predictors
input = process.input(input.info, sample.overlap, ref.prefix, phenos = c("hypertension","T2D","whr","bmi"))

b = c = list()

# iterate over loci
for (locus_id in c("1209","2135")) {
	# process locus
	locus = process.locus(subset(loci, LOC==locus_id), input)
	
	# bivariate analysis 
	b[[locus_id]] = run.bivar(locus, target="hypertension")
	
	# multiple regression with hypertension as outcome
	c[[locus_id]] = list()
	c[[locus_id]] = run.multireg(locus, phenos=c("T2D","bmi","whr","hypertension"))
}

