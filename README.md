# LAVA analysis scripts 
### Werme, van der Sluis, Posthuma, de Leeuw (2021)

This repository contains the scripts used to generate the main results for the first LAVA paper, together with the specific package version of LAVA which was used to conduct the analyses.

## Scripts
#### **bivariate.R**
This is the script used to generate the univariate and bivariate local rg results. The analyses were performed on a cluster computer, analysing all the pairs of phenotypes separately. The script can be called from the command line directly or within a bash script as: 
``` bash
Rscript bivariate.R $REFDAT $LOCFILE $INFOFILE $OVERLAPFILE "$PHEN1;$PHEN2" $OUTNAME
```

where the bash variables represent:
``` bash
$REFDAT # the reference data prefix
$LOCFILE # the name of the locus file 
$INFOFILE # name of the input info file
$OVERLAPFILE # name of sample overlap file
"$PHEN1;$PHEN2" # the current phenotypes
$OUTNAME # the prefix for the output files
```

(see the script for more detail)


#### **conditional.R**
This is the script used to generate the results for the conditional analyses. The script was run on a desktop locally exactly as indicated in the script

## Package version
#### **lava.v0.0.6**
This directory containes the entire R package that was used to perform the analyses (including README and example data). The locus file used for the analyses can be found in lava.v0.0.6/support_data. Note that this directory only contains the package version used for the paper - to download the most recent version, go to https://github.com/josefin-werme/LAVA
