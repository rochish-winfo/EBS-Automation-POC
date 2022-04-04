from pyjab.jabdriver import JABDriver
from robot.api.deco import keyword
import logging
import time
import win32api as win32
import win32gui as win32gui
import win32con as win32con
import time
from RPA.Desktop import Desktop
from io import BytesIO
from PIL import Image, ImageFile, ImageGrab
import oci


APPLICATION = "Oracle Applications - EBSVIS"
PATH = "C:\\GitHub\\EBS-Automation-POC\\Driver\\WindowsAccessBridge-64.dll"
# driver = JABDriver(APPLICATION, PATH)
logger = logging.getLogger(__name__)
desktop = Desktop()
LOV = "List of Values"
driver = None


def _is_wait_cursor_complete() :
    try:
        bool = 'False'
        start = time.time()
        while bool == 'False':
            hCursor = win32gui.SetCursor(win32gui.LoadCursor(0, win32con.IDC_WAIT))
            hCursor = win32gui.SetCursor(win32gui.LoadCursor(0, win32con.IDC_ARROW))
            currCur = win32gui.GetCursorInfo()[1]
            time.sleep(0.1)
            if hCursor !=currCur:
                bool = 'True'
        end = time.time()
        logger.info(f'Loading completed in {end - start}')
        # setDriver()
    except Exception as e :
        raise Exception(f"Screen is off, {e}")

def setDriver(name = APPLICATION):
    try :
        driver = JABDriver(name, PATH)
        logger.info("The JABDriver is initialized")
    except Exception as e:
        raise Exception("Jab Wrapper Failed")


def take_screeshot_as_jpg(path):
    """
        It will take screenshot as jpg and will upload the file to object store.
    """
    #to be written
    # pass
    try :
        snapshot = ImageGrab.grab()
        snapshot.save(path)
        config = oci.config.from_file("C:\\oci\\config","WATS_WINFOERP")
        object_storage = oci.object_storage.ObjectStorageClient(config)
        namespace = object_storage.get_namespace().data
        bucket_name = "obj-watsdev01-standard"
        path_name="/".join(path.split("\\")[-4:-1])
        logger.info(f"Uploading to {path_name} in oci") 
        object_name="/".join(path.split("\\")[-4:])

        ImageFile.MAXBLOCK = 2**20
        imagefile = BytesIO()

        img = Image.open(path)

        img.save(imagefile, "JPEG", quality=80, optimize=True, progressive=True)

        imagedata = imagefile.getvalue()
        obj = object_storage.put_object(

            namespace,

            bucket_name,

            object_name,

            imagedata)

        logger.info(f"Uploaded to {path_name} in oci") 
    except Exception as e :
        raise  Exception(e," file upload failed")

start_time = time.time()

try :

    trycounter = 0
    _is_wait_cursor_complete()

    """
        pass_path , fail_path, name and step['input_parameter] will be replaced by java

    """

    trycounter = 0
    _is_wait_cursor_complete()
    #set driver or select window action
    while trycounter < 3 :
        try :
            trycounter += 1
            setDriver()
            take_screeshot_as_jpg(pass_path)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(fail_path)
                raise Exception(exception)

    trycounter = 0
    _is_wait_cursor_complete()
    #ebsclick button
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = f"//push button[@name=contains('{step['input_parameter']}')]"
            btn = driver.find_element_by_xpath(XPATH)
            btn.click()
            take_screeshot_as_jpg(pass_path)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(fail_path)
                raise Exception(exception)

    trycounter = 0
    _is_wait_cursor_complete()
    #clickelement action
    while trycounter < 3 :
        try :
            elm = driver.find_element_by_name(step['input_parameter'])
            elm.click()
            logger.info(f"Clicked Element {step['input_parameter']}")
            take_screeshot_as_jpg(pass_path)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(fail_path)
                raise Exception(exception)

    trycounter = 0
    _is_wait_cursor_complete()
    #type text
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = f"//text[@name=contains('{step['input_parameter']}')]"
            txtelement = driver.find_element_by_xpath(XPATH)
            txtelement.send_text(value=step['input_value'], simulate=True)
            take_screeshot_as_jpg(pass_path)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(fail_path)
                raise Exception(exception)

    trycounter = 0
    _is_wait_cursor_complete()
    #click check box
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = f"//check box[@name=contains('{step['input_parameter']}')]"
            checkbox = driver.find_element_by_xpath(XPATH)
            checkbox.click()
            take_screeshot_as_jpg(pass_path)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(fail_path)
                raise Exception(exception)

    
    trycounter = 0
    _is_wait_cursor_complete()
    #select dropdown
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = f"//combo box[@name=contains('{step['input_parameter']}')]"
            selectVal =  driver.find_element_by_xpath(XPATH)
            selectVal.select(option=step['input_value'], simulate=True)   
            take_screeshot_as_jpg(pass_path)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(fail_path)
                raise Exception(exception)

    trycounter = 0
    _is_wait_cursor_complete()
    #click radio button
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = f"//radio button[@name=contains('{step['input_parameter']}')]"
            radiobtn = driver.find_element_by_xpath(XPATH)
            radiobtn.click()
            take_screeshot_as_jpg(pass_path)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(fail_path)
                raise Exception(exception)

    trycounter = 0
    _is_wait_cursor_complete()
    #close ebs
    while trycounter < 3 :
        try :
            trycounter += 1
            desktop.press_keys("alt","f4")
            time.sleep(5)
            desktop.press_keys("enter")
            take_screeshot_as_jpg(pass_path)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(fail_path)
                raise Exception(exception)

    trycounter = 0
    _is_wait_cursor_complete()
    #close popup
    while trycounter < 3 :
        try :
            trycounter += 1
            desktop.press_keys("ctrl","f4")
            time.sleep(5)
            take_screeshot_as_jpg(pass_path)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(fail_path)
                raise Exception(exception)

except Exception as e :
    print(f"Exception Happened {e}")

end_time = time.time()
logger.info(f"The Execution completed in {end_time - start_time}")