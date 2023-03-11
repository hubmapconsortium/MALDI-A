import cv2
import os
import sys
import glob
from PIL import Image, ImageDraw 
import tifffile as tiff
import numpy as np


image1=sys.argv[1]
fnm1=os.path.splitext(image1)[0]
#print(fnm1)
fnm1=fnm1+"_ROI.tif"
print(fnm1)

image2=sys.argv[2]
fnm2=os.path.splitext(image2)[0]
#print(fnm2)
fnm2=fnm2+"_ROI.tif"
print(fnm2)

image3=sys.argv[3]
fnm3=os.path.splitext(image3)[0]
#print(fnm3)
fnm3=fnm3+"_ROI.tif"
print(fnm3)

image4=sys.argv[4]
fnm4=os.path.splitext(image4)[0]
#print(fnm4)
fnm4=fnm4+"_ROI.tif"
print(fnm4)

image1=tiff.imread(sys.argv[1])
image2=tiff.imread(sys.argv[2])
image3=tiff.imread(sys.argv[3])
image4=tiff.imread(sys.argv[4])
#print(image1.shape)
#print(image1.dtype)

img1 = np.array(image1)
r1 = image1[16542:22933,13620:46065]
img2 = np.array(image2)
r2 = image2[16542:22933,13620:46065]
img3 = np.array(image3)
r3 = image3[16542:22933,13620:46065]
img4 = np.array(image4)
r4 = image4[16542:22933,13620:46065]

fnm5=fnm4+"_Mask.tif"
r5=np.ones(r4)
#print(r1)
#print(r1.dtype)
#print(r1.shape)

tiff.imwrite(fnm1, r1)
tiff.imwrite(fnm2, r2)
tiff.imwrite(fnm3, r3)
tiff.imwrite(fnm4, r4)
tiff.imwrite(fnm5, r5)
