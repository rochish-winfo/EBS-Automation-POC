from sys import prefix
from xml.sax.handler import feature_external_ges
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


    print("Uploading new object {!r}".format(object_name))

    # obj = object_storage.put_object(

    #     namespace,

    #     bucket_name,

    #     object_name,

    #     imagedata)
    print("path: ",path)
    print("pathName :", path_name)
    print("prefix: " , path.split('\\')[-1].split('_')[0])
    listfiles  = object_storage.list_objects(
        namespace, bucket_name, prefix = path_name
    )
    # print(object_name)
    for filename in listfiles.data.objects:
        print(filename.name)
        name = filename.name.split('/')[-1]
        if name.startswith(path.split('\\')[-1].split('_')[0]):
            print(name)
        # try :
        #     delete_object_response = object_storage.delete_object(
        #     namespace,
        #     bucket_name,
        #     filename.name,
        #     )
        #     print(delete_object_response.headers)
        # except :
        #     print('delete failed for filename ', filename)
        
 

    logger.info(f"Uploaded to {path_name} in oci") 
    print(f"Uploaded to {path_name} in oci") 

put_object_to_cloud("C:\\WATS\\Screenshot\\WATS\\Pyjab Demo Internal\\1_10_Create Purchase Requisition_PTP.PO.2028-Demo1_Pyjab Demo Internal_10_Passed.jpg","1_10_Create Purchase Requisition_PTP.PO.2028-Demo1_Pyjab Demo Internal_10_Passed.jpg")

