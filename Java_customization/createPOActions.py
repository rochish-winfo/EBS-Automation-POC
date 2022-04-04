from curses import panel
from textwrap import dedent
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

from Java_customization.createPO import XPATH


APPLICATION = "Oracle Applications - EBSVIS"
PATH = "C:\\GitHub\\EBS-Automation-POC\\Driver\\WindowsAccessBridge-64.dll"
# driver = JABDriver(APPLICATION, PATH)
logger = logging.getLogger(__name__)
desktop = Desktop()
LOV = "List of Values"
driver = None

#Wait For Cursor
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

#Select Window
def setDriver(name = APPLICATION):
    try :
        global driver
        driver = JABDriver(name, PATH)
        logger.info("The JABDriver is initialized")
    except Exception as e:
        raise Exception("Jab Wrapper Failed")

#Taking screenshot and uploading it
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
        # raise  Exception(e," file upload failed")
        print(e,'upload failed') # just for testing


#get xpath as per requirement for ebs
def get_ebs_xpath(element, name, hasTable = False):
    try :
        XPATH = ''
        if element == 'button':
            XPATH = f'//push button[@name=contains("{name}")]'
        elif element == 'text' :
            XPATH = f'//text[@name=contains("{name}")]'
        elif element == 'checkbox':
            XPATH = '//check box' if name == '' else f'//check box[@name=contains("{name}")]'
        elif element == 'radio':
            XPATH = '//radio button' if name == '' else f'//radio button[@name=contains("{name}")]'
        elif element == 'combobox':
            XPATH = '//combo box' if name == '' else f'//combo box[@name=contains("{name}")]'
        elif element == 'tab':
            XPATH = '//page tab' if name == '' else f'//page tab[@name=contains("{name}")]'
        else:
            raise Exception("Please provide valid element or name")
        return XPATH
    except Exception as E :
        raise Exception(E)

# click push button
def ebsClickButton(xpath_param, path_to_screenhot, screenshot_file_name):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = get_ebs_xpath(xpath_param, 'button')
            btn = driver.find_element_by_xpath(XPATH)
            btn.click()
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(exception)

#ebsEnterTextVal 
def ebsEnterTextVal(xpath_param, input_value, path_to_screenhot, screenshot_file_name):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = get_ebs_xpath(xpath_param, 'text')
            txtelement = driver.find_element_by_xpath(XPATH)
            txtelement.send_text(value=input_value, simulate=True)
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(exception)
    

#ebsClickCheckBox
def ebsClickCheckBox(xpath_param, path_to_screenhot, screenshot_file_name):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = get_ebs_xpath(xpath_param, 'checkbox')
            btn = driver.find_element_by_xpath(XPATH)
            btn.click()
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(exception)

#click radio button
def ebsClickRadioButton(xpath_param, path_to_screenhot, screenshot_file_name):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = get_ebs_xpath(xpath_param, 'radio')
            btn = driver.find_element_by_xpath(XPATH)
            btn.click()
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(exception)

#ebs dropdown
def ebsDropDown(xpath_param, input_value, path_to_screenhot, screenshot_file_name):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = get_ebs_xpath(xpath_param, 'combobox')
            selectVal =  driver.find_element_by_xpath(XPATH)
            selectVal.select(option=input_value, simulate=True)   
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(exception)
#ebs save
def ebsSave():
    desktop.press_keys('ctrl','s')

#ebs Tab
def ebsTabKey():
    desktop.press_keys('tab')

#ebs enter
def ebsEnter():
    desktop.press_keys('enter')

#ebs down
def ebsDownKey():
    desktop.press_keys('down')


# select window and security changes
def ebsSelectWindow(xpath_param, path_to_screenhot, screenshot_file_name):
    # xpath_param is application name
    try :
        _is_wait_cursor_complete()
        setDriver("Security Warning")
        checkbox = driver.find_element_by_xpath("//check box[@name=contains('I accept the risk and want to run this application')]")
        checkbox.click()
        runbtn = driver.find_element_by_xpath("//push button[@name=contains('Run')]")
        runbtn.click()
        _is_wait_cursor_complete()
        setDriver(xpath_param)
        _is_wait_cursor_complete()
        take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
    except Exception as E :
        take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
        raise Exception(E)
        

#ebsClosePopUP
def ebsClosePopUp(path_to_screenhot, screenshot_file_name):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            desktop.press_keys("ctrl","f4")
            time.sleep(5)
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(exception)

#CloseWindows
def ebsCloseWindows(path_to_screenhot, screenshot_file_name):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            desktop.press_keys("f4")
            time.sleep(5)
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(exception)



#ebsExitApp
def ebsExitApp(path_to_screenhot, screenshot_file_name):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            desktop.press_keys("alt","f4")
            time.sleep(5)
            desktop.press_keys("enter")
            time.sleep(5)
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(exception)


#ebsSelectTab
def ebsSelectTab(xpath_param, input_value, path_to_screenhot, screenshot_file_name):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = get_ebs_xpath(xpath_param, 'tab')
            selectVal =  driver.find_element_by_xpath(XPATH)
            selectVal.select(option=input_value, simulate=True)   
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(exception)

if __name__ == '__main__':
    try :
        _is_wait_cursor_complete()
        path_to_screenhot ='C:\\GitHub\\EBS-Automation-POC\\Java_customization\\'
        screenshot_file_name = '1.jpg'
        ebsSelectWindow("Oracle Applications - EBSVIS",path_to_screenhot, '1.jpg')
        ebsEnterTextVal('Item','AS54888')
        ebsDownKey()
        ebsEnterTextVal('Quantity','10')
        ebsEnterTextVal('Price','10')
        i

    except Exception as e :
        print("Execution Failed")



    


