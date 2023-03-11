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
scale=float(sys.argv[2])

fnm1=os.path.splitext(image1)[0]
#print(fnm1)
fnm1=fnm1+"_Rsz.tif"
print(fnm1)

data = imread(image1)
print(data.shape)

#wpercent = new_wd/data.shape[0]
#print(wpercent)
#hsize = data.shape[1]*wpercent
#img = img.resize((mywidth,hsize), PIL.Image.ANTIALIAS)

rs_x=int(data.shape[0]/scale)
rs_y=int(data.shape[1]/scale)

#rs_x=int(data.shape[1])
#rs_y=int(hsize)
resized_data = cv2.resize(data, (rs_y, rs_x))
print(resized_data.shape)
imwrite(fnm1, resized_data, planarconfig='CONTIG')
