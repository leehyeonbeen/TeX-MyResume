import cv2
import glob
from PIL import Image
from pillow_heif import register_heif_opener

register_heif_opener()

jpegs = glob.glob("pictures/styled_pics/*.JPEG") + glob.glob(
    "pictures/styled_pics/*.jpeg"
)
heics = glob.glob("pictures/styled_pics/*.HEIC") + glob.glob(
    "pictures/styled_pics/*.heic"
)

for p in jpegs + heics:
    filepath = ".".join(p.split(".")[:-1])
    img = Image.open(p)
    img.convert("RGB").save(f"{filepath}.jpg")
    print(f"Converted: {filepath}.jpg")
    # img = cv2.imread(p)
    # path = p.split("/")
    # path.insert(-1, "jpg")
    # path = "/".join(path).replace("jpeg", "jpg")
    # cv2.imwrite(path, img, [int(cv2.IMWRITE_JPEG_QUALITY), 100])
    # pass
