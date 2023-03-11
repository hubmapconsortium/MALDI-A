#!/bin/bash

DATA_L=/data_no_backup/de713126/DATA/Hubmap/MALDI/
PROG=/data_no_backup/de713126/SCRIPTS/Hubmap/Hubmap_Docker/PROG
DONRR=$PROG/NiftyReg/build/reg-apps

STARTF=$(date +%s)
#CASES=(VAN0053  VAN0057  VAN0060  VAN0061)
CASES=(VAN0057)
#TYPE=(IMS CD)
TYPE=(LK_2_241_ITO2)

cd $DATA_L
#Pre-processing CD images
for((c=0;c<${#CASES[@]};c++))
do
  #DAPI Segmentation Deep Learning
  for((t=0;t<${#TYPE[@]};t++))
  do
       STARTF=$(date +%s)
       echo ${CASES[$c]}_${TYPE[$t]} 
       #Generate mask and DAPI segmentation
       #Full resolution 20x
       python3 $PROG/MALDI_Process/CreateMaskMaldi.py $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/S002_VHE_region_001.tif
       echo "Mask created"

       #DAPI Segmentation deep learning convert image and binary threshold 
       python3 $PROG/hubmap_segmentation/DAPI_Seg_MALDI.py $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/S001_mono_dapi_reg_pyr16_region_001.tif $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/S001_VHE_region_001_Mask.tif $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/S001_DAPI_region_001_nucseg.tif 
       echo "DAPI segmentation completed"

       #Cell ID to csv
       $PROG/LabelStatisticsImageFilter/build/LabelShapeFilter2D $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/S001_DAPI_region_001_nucseg.tif $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/S001_DAPI_nucseg.csv 1

       #Downsample for GMM Tif
       python3 $PROG/MALDI_Process/ResizeTiff.py $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/AQP1_AFRemoved_S003_pyr16_region_001.tif 4
       python3 $PROG/MALDI_Process/ResizeTiff.py $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/PCAD_AFRemoved_S004_pyr16_region_001.tif 4
       python3 $PROG/MALDI_Process/ResizeTiff.py $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/NAKATPASE_AFRemoved_S003_pyr16_region_001.tif 4
       echo "Down sampling complete"

       #GMM Segmentation
       $PROG/ClassSeg/build/ClassSeg2D_CD_Tif $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/AQP1_AFRemoved_S003_pyr16_region_001_Rsz.tif
       $PROG/ClassSeg/build/ClassSeg2D_CD_Tif $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/NAKATPASE_AFRemoved_S003_pyr16_region_001_Rsz.tif
       $PROG/ClassSeg/build/ClassSeg2D_CD_Tif $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/PCAD_AFRemoved_S004_pyr16_region_001_Rsz.tif 
       echo "GMM completed"
      
       python3 $PROG/MALDI_Process/UpsampleTiff.py $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/AQP1_AFRemoved_S003_pyr16_region_001.tif $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/AQP1_AFRemoved_S003_pyr16_region_001_Rsz_Prob.tif
       python3 $PROG/MALDI_Process/UpsampleTiff.py $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/AQP1_AFRemoved_S003_pyr16_region_001.tif $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/NAKATPASE_AFRemoved_S003_pyr16_region_001_Rsz_Prob.tif
	python3 $PROG/MALDI_Process/UpsampleTiff.py $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/AQP1_AFRemoved_S003_pyr16_region_001.tif $DATA_L/${CASES[$c]}/${CASES[$c]}_${TYPE[$t]}/PCAD_AFRemoved_S004_pyr16_region_001_Rsz_Prob.tif 
	echo "Up-sampling completed"

      
      ENDF=$(date +%s)
      DIFF=$(( $ENDF - $STARTF ))
      echo "${Type[$t]} done in" $DIFF "seconds" 
  done  
  echo "${CASES[$c]} done"
done







	




