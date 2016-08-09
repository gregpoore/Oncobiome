# !/bin/bash
# ----------------------------------------------------------------------------
# Copyright (c) 2016--, Gregory Poore.
#
# Distributed under the terms of the Modified BSD License.
#
# Dependencies:
# - GNU datamash (http://www.gnu.org/software/datamash/)
# 
# Resources used in making this script:
# - http://unix.stackexchange.com/questions/60577/concatenate-multiple-files-with-same-header
# - http://onetipperday.sterding.com/2014/09/transpose-tab-delimited-file.html
# ----------------------------------------------------------------------------

for f in All_CDEs*.txt
do
    echo "Transposing $f file... Saved as Transposed_$f"
    cat $f | datamash transpose > Transposed_$f
done

echo "Transposing complete!"

### The code below would append all the files together.
### However, after closer examination, it appears that not all of the
### metadata tables have the same number of columns. A full join (logical sets)
### could be done, but this would result in redundant, hard-to-access data.
### Thus, the transposed files as left as-is until a definite set of metadata columns
### are selected for the analysis.

# echo "Transposing complete! Appending files..."

# awk '
#     FNR==1 && NR!=1 { while (/^bcr_patient_barcode/) getline; }
#     1 {print}
# ' Transposed_All_CDEs*.txt > Appended_Transposed_All_CDEs.txt

# echo "File appending complete! Removing intermediate files and saving output under Appended_Transposed_All_CDEs.txt"

# #rm -f Transposed*.txt