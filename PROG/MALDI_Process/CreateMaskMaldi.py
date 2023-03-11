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
fnm1=fnm1+"_Mask.tif"
print(fnm1)

image1=tiff.imread(sys.argv[1])
print(image1.shape)

img1=cv2.cvtColor(image1, cv2.COLOR_BGR2GRAY)
print(img1.shape)
ret2,th2 = cv2.threshold(img1,127,1,cv2.THRESH_BINARY_INV)
print(ret2)
# Otsu's thresholding after Gaussian filtering
blur = cv2.GaussianBlur(th2,(5,5),0)
ret3,th3 = cv2.threshold(th2,127,255,cv2.THRESH_OTSU)
tiff.imwrite(fnm1, th3)
