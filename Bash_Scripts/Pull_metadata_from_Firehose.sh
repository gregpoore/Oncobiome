#!/bin/sh
# ----------------------------------------------------------------------------
# Copyright (c) 2016--, Gregory Poore.
#
# Distributed under the terms of the Modified BSD License.
#
# Adapted from https://github.com/cczysz/tcga/blob/master/mirna_dl.sh
# ----------------------------------------------------------------------------

# FTP dir
# http://gdac.broadinstitute.org/runs/stddata__2016_01_28/

# Example clinical phenotypes link
# http://gdac.broadinstitute.org/runs/stddata__2016_01_28/data/BRCA/20160128/gdac.broadinstitute.org_BRCA.Clinical_Pick_Tier1.Level_4.2016012800.0.0.tar.gz

diseasetypes='ACC BLCA BRCA CESC CHOL COAD DLBC ESCA GBM HNSC KICH KIRC KIRP LAML LGG LIHC LUAD LUSC MESO OV PAAD PCPG PRAD READ SARC SKCM STAD TGCT THCA THYM UCEC UCS UVM'

for i in $(echo $diseasetypes); do

	phenlink=http://gdac.broadinstitute.org/runs/stddata__2016_01_28/data/$i/20160128/gdac.broadinstitute.org_$i.Clinical_Pick_Tier1.Level_4.2016012800.0.0.tar.gz
	outf=$i.tar.gz;
	curl -L $phenlink -o ./$outf;
	mkdir -p ./$i;
	tar -xvf ./$i.tar.gz -C ./$i --strip-components=1;
	cd ./$i
	for file in *.txt; do mv "$file" "${file/.txt/_$i.txt}"; done
	cd ..
done;

# Create directory of combined clinical phenotype files
mkdir Combined_CDEs
# Search through all subdirectories EXCEPT ./Combined_CDEs, extract Combined_CDEs*.txt files, and copy them into the new directory
find . -path ./Combined_CDEs -prune -o -name \All_CDEs*.txt -exec cp {} ./Combined_CDEs \;

# Clean up gunzipped files
rm *.tar.gz