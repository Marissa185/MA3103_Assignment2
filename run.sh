#!/bin/bash

# 2. Get the full absolute path of that new folder
#LOCAL_BIN_PATH=$./bin

# 3. Add it to the PATH for this session
#export PATH="$LOCAL_BIN_PATH:$PATH"

# 0_ delete folder named work
rm -rf ./work/

# 1_ make a directory for it to hold all of the output
mkdir -p ./work/

# Alignment using Clustal Omega in default mode
clustalo -i Norovirus_PP.fasta -o ./work/1_Norovirus_PP_clustalo.fst

# 2_ Using Alistat to survey ths MSA in Norovirus_PP_clustalo.fst 
mkdir -p ./work/2_alistat/ && (cd ./work/2_alistat/ && alistat ../../work/1_Norovirus_PP_clustalo.fst 6 -t -i 2)

# Prints the summary log of Alistat
echo -e "\n *clustalo_Summary.txt* \n"
cat ./work/2_alistat/Summary.txt

# 3_ compile the Histograms generated
(cd ./work/2_alistat/ && Rscript Histogram_Cr.R && Rscript Histogram_Cc.R) #&& (mkdir -p ../3_histogram && mv Histogram_Cc.pdf Histogram_Cr.pdf ../3_histogram))
pdfunite ./work/2_alistat/Histogram_Cr.pdf ./work/2_alistat/Histogram_Cc.pdf ./work/3_MSA_Histogram_.pdf

# 4_ Using Alistat to mask the ...
mkdir -p ./work/4_mask/ && (cd ./work/4_mask/ && alistat ../../work/1_Norovirus_PP_clustalo.fst 6 -m 0.75)

# Prints the summary log of Alistat masking
echo -e "\n clustalo_mask_Summary.txt\n"
cat ./work/4_mask/Summary.txt

# 5_ Using homo to test for homogeneity 
mkdir -p ./work/5_homo/ && (cd ./work/5_homo/ && homo ../../work/4_mask/Mask.fst f 31)

## generate ppplot
#Rscript ppplot.R (mv P-values.pdf ./work/7_)

# 6_ using iqtree3 to find a model and gen
mkdir -p ./work/6_model/ && (cd ./work/6_model/ && iqtree3 -s 5_mask/clustalo/Mask.fst -m MFP -bb 1000 -alrt 1000)
iqtree3 -s 5_mask/clustalo/Mask.fst -m MFP -bb 1000 -alrt 1000 -pre work/6_model/Mask