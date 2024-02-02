import cv2
import glob
from PIL import Image
from pillow_heif import register_heif_opener
import os

register_heif_opener()

jpegs = glob.glob("pictures/styled_pics/*.JPEG") + glob.glob(
    "pictures/styled_pics/*.jpeg"
)
heics = glob.glob("pictures/styled_pics/*.HEIC") + glob.glob(
    "pictures/styled_pics/*.heic"
)
raw_pics = glob.glob("pictures/styled_pics/raw/*")

for p in raw_pics:
    filesize = os.path.getsize(p)
    savepath = ".".join(p.split(".")[:-1]).replace("raw/", "")
    img = Image.open(p)
    if filesize > 700 * 1024:
        quality = 700 * 1024 / filesize * 100
        img.convert("RGB").save(f"{savepath}.jpg", quality=int(quality))
    print(f"Converted: {savepath}.jpg")
    # img = cv2.imread(p)
    # path = p.split("/")
    # path.insert(-1, "jpg")
    # path = "/".join(path).replace("jpeg", "jpg")
    # cv2.imwrite(path, img, [int(cv2.IMWRITE_JPEG_QUALITY), 100])
    # pass
