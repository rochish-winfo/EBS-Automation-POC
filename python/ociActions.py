import oci
from robot.api.deco import keyword
from io import BytesIO
from PIL import Image, ImageFile
import logging



@keyword
def put_object_to_cloud(path, file):
    logger = logging.getLogger(__name__)
    config = oci.config.from_file("C:\\oci\\config","WATS_WINFOERP")
    object_storage = oci.object_storage.ObjectStorageClient(config)
    namespace = object_storage.get_namespace().data
    bucket_name = "obj-watsdev01-standard"
    logger.info(f"Given {path}") 
    # file_name=f"file.split(.)[0].jpg"
    path_name="/".join(path.split("\\")[-4:-1])

    logger.info(f"Uploading to {path_name} in oci") 
    # object_name =f"ebs/WATS/TestEBS/{file}"
    object_name=f"{path_name}/{file}"

    ImageFile.MAXBLOCK = 2**20
    imagefile = BytesIO()

    img = Image.open(path)

    img.save(imagefile, "JPEG", quality=80, optimize=True, progressive=True)

    imagedata = imagefile.getvalue()


    # print("Uploading new object {!r}".format(object_name))

    obj = object_storage.put_object(

        namespace,

        bucket_name,

        object_name,

        imagedata)

    logger.info(f"Uploaded to {path_name} in oci") 


# put_object_to_cloud("C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEBS","1000.jpg")

