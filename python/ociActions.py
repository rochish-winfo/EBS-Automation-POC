import oci
from robot.api.deco import keyword
from io import BytesIO
from PIL import Image, ImageFile



@keyword
def put_object_to_cloud(path, file):
    config = oci.config.from_file("C:\\oci\\config","WATS_WINFOERP")
    object_storage = oci.object_storage.ObjectStorageClient(config)
    namespace = object_storage.get_namespace().data
    bucket_name = "obj-watsdev01-standard"
    # file_name=f"file.split(.)[0].jpg"
    path_name="/".join(path.split("\\")[-3:]) 
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


# put_object_to_cloud("C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEBS","1000.jpg")

