# MALDI-A
MALDI analysis repository
1. Create folder $YOUR_WORKING_DIRECTORY 
2. Pull docker container: docker pull hubmap/gehc:skin from $YOUR_WORKING_DIRECTORY
3. Clone repository from [MALDI-A](https://github.com/hubmapconsortium/MALDI-A.git)   
5. Load docker container: nvidia-docker run --rm -it -v $YOUR_WORKING_DIRECTORY hubmap/gehc:skin
6. Run shell script to segment nuclei (DAPI) and create a probabilitic map of biomarkers AQP1, PCAD etc. From docker prompt: ./MALDI-A/SCRIPTS/Segmentation.sh. This script segments DAPI (nuclei segmentation), use Gaussian mixture model to assign probabilities to biomarkers.   
