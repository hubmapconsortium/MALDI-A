import cv2
import os
import sys
import glob
from PIL import Image
import tifffile as tiff
import numpy as np
from PIL import Image
from tifffile import imread, imwrite
from skimage.transform import resize

image1=sys.argv[1]
image2=sys.argv[2]

fnm1=os.path.splitext(image2)[0]
#print(fnm1)
fnm1=fnm1+"_Upsmp.tif"
print(fnm1)

data = imread(image1)
print(data.shape)
data2=imread(image2)
print(data2.shape)

rs_x=data.shape[0]
rs_y=data.shape[1]

resized_data = cv2.resize(data2, (rs_y, rs_x))
print(resized_data.shape)
imwrite(fnm1, resized_data, planarconfig='CONTIG')
