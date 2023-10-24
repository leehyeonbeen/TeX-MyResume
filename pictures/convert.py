import cv2
import glob

for p in glob.glob('pictures/styled_pics/*.jpeg'):
    img=cv2.imread(p)
    path=p.split('/')
    path.insert(-1, 'jpg')
    path='/'.join(path).replace('jpeg','jpg')
    cv2.imwrite(path,img, [int(cv2.IMWRITE_JPEG_QUALITY), 100])
    pass