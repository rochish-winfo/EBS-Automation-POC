from pyjab.jabdriver import JABDriver
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
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
from selenium.webdriver.support.ui import Select
import json
import requests as req

start_time = time.time()

logger = logging.getLogger(__name__)
chrome_driver_path = 'C:/Github/EBS-Automation-POC/Driver/chromedriver.exe'
url = 'http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp?'
username = 'gchockal'
password = 'welcome123'
# toNavigate = 'Purchasing, Vision Operations (USA)>Requisitions>Requisitions'
toNavigate = 'iProcurement>iProcurement Home Page'
isFrameSwithed = False
post_url = '/updateScriptParamStatus'

response  = {
        "scriptParamId":"",
        "message":"",
        "success": True}
      
def setResponse(scriptParamId, message, success, copy = None):
    response['scriptParamId'] = scriptParamId
    response['message'] = message
    response['success'] = success
    if copy is not None :
        response[copy[0]] = copy[1]

def getResponse():
    return response

def sendResponse():
    req.post(post_url, json.dumps(getResponse()))


APPLICATION = "Oracle Applications - EBSVIS"
PATH = "C:\\GitHub\\EBS-Automation-POC\\Driver\\WindowsAccessBridge-64.dll"
logger = logging.getLogger(__name__)
desktop = Desktop()
LOV = "List of Values"
driver = None
chrome_driver_path = 'C:/Github/EBS-Automation-POC/Driver/chromedriver.exe'

#defining chrome options
def options():
    options = webdriver.ChromeOptions()
    options.add_argument('--start-maximized')
    options.add_argument("--disable-gpu")
    options.add_argument("--disable-web-security")
    options.add_argument("--allow-running-insecure-content")
    options.add_experimental_option("prefs",{'download.prompt_for_download':True})
    return options

#get xpath for selenium
def get_xpath(name, tagname):
    if len(name.split('>')) > 1 :
        name1 = name.split('>')[0]
        name = name.split('>')[-1]
        xpath = f'//*[text()="{name1}"]//following::'
    else :
        xpath = '//'
    if tagname == 'link':
        xpath += f'a[text()="{name}"]'
    elif tagname == 'button' :
        
        if name == 'Submit':
            xpath += f'button[contains(@title,"Submit")]'
        else :
            xpath += f'button[text()="{name}"]'
    elif tagname == 'input':
        xpath += f'input[@name="{name}"]'
    elif tagname == 'radio' :
        xpath += f'*[text()="{name}"]//ancestor::td//input[@type="radio"]'
    elif tagname == 'dropdown':
        xpath += f'*[text()="{name}"]//following::select[1]'
    elif tagname == 'textarea':
        xpath += f'*[text()="{name}"]//following::textarea[1]'
    elif tagname == 'searchField':
        xpath += f'*[text()="{name}"]//following::input[1]'
    elif tagname == 'frame':
        name = 'iframe' + ''.join(name.split()) + 'Popup'
        xpath += f'iframe[@id="{name}"]'
    elif tagname == 'b' :
        xpath += f'b[contains(text(),"{name}")]'
    else :
        xpath += f'*[text()="{name}"]'
    return xpath

#get navigation xpath for selenium
def create_xpath(navigation):
    to_navigate = navigation.split('>')
    XPATH = []
    constantPathValueStart = '(//div[text()="'
    constantPathValueEnd = '"]/parent::a//img[@title])[1]'
    XPATH.append(f"//div[text()='{to_navigate[0]}']")
    for i in range(1,len(to_navigate) - 1):
        XPATH.append(constantPathValueStart + to_navigate[i] + constantPathValueEnd)
    
    if len(to_navigate) > 2 :
        if to_navigate[-1] == to_navigate[-2] :
            XPATH.append(constantPathValueStart + to_navigate[-2] + '"]//following::div[text()="'+ to_navigate[-1] +'"][2])') 
        elif to_navigate[-1] == to_navigate[-3]:
            XPATH.append(constantPathValueStart + to_navigate[-2] + '"]//following::div[text()="'+ to_navigate[-1] +'"][1])') 
        else :
            XPATH.append(constantPathValueStart+to_navigate[-1]+'"])[1]') 
    else:
        XPATH.append(constantPathValueStart+to_navigate[-1]+'"])[1]') 
    return XPATH

def save_and_open_jnlp():
    time.sleep(5)
    desktop.press_keys('enter')
    time.sleep(5)
    desktop.press_keys('ctrl', 'j')
    time.sleep(5)
    desktop.press_keys('tab')
    time.sleep(0.1)
    desktop.press_keys('tab')
    time.sleep(0.1)
    desktop.press_keys('enter')
    time.sleep(2)
    desktop.press_keys('ctrl','w')
    time.sleep(10)

#def upload screenshot in jpg format
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


_passed = '_Passed.jpg'
_failed = '_Fail.jpg'

selenium_driver = webdriver.Chrome(executable_path=chrome_driver_path, options=options())


def logInToEBS(url, username, password, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    while trycounter < 3 :
        try : 
            trycounter += 1
            selenium_driver.get(url)
            username_field = selenium_driver.find_element_by_xpath('//*[@name="usernameField"]')
            password_field = selenium_driver.find_element_by_xpath('//*[@name="passwordField"]')
            login_btn = selenium_driver.find_element_by_xpath('//button[text()="Log In"]')
            username_field.send_keys(username)
            password_field.send_keys(password)
            login_btn.click()
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            trycounter = 3
            setResponse(scriptParamId, 'Login to Ebs is Successful', True)
            sendResponse()
        except Exception as e :
            if trycounter < 3 : continue
            else : 
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, 'Login to Ebs is Failed', False)
                sendResponse()
                raise Exception(e)
    

def ebsSwitchWindow(path_to_screenhot, screenshot_file_name, scriptParamId):
    try :
        desktop.press_keys('ctrl','w')
        time.sleep('2')
        take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
        setResponse(scriptParamId, 'SwitchWindow is SuccessFull', True)
        sendResponse()
    except Exception as e:
        take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
        setResponse(scriptParamId, 'SwitchWindow is Failed', False)
        sendResponse()
        raise Exception(e)
    # to be done generic
    # since we are using two driver so it is not particularly required now

def ebsNavigate(navigation, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    while trycounter <  3 :
        try :
            trycounter += 1
            XPATHS = create_xpath(navigation)
            print(XPATHS)
            for xpath in XPATHS :
                print(xpath)
                _wait_until_element_is_found(xpath)
                xpath_field = selenium_driver.find_element_by_xpath(xpath)
                xpath_field.click()
                time.sleep(2)
            trycounter = 3
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Navigation is Successfull to {navigation.split(">")[-1]}', True)
            sendResponse()
        except Exception as e :
            if trycounter < 3 : continue
            else : 
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Navigation is Failed to {navigation.split(">")[-1]}', False)
                sendResponse()
                raise Exception(e)

def ebsOpenDownloadedFile(path_to_screenhot , screenshot_file_name, scriptParamId):
    try :
        save_and_open_jnlp()
        take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
        setResponse(scriptParamId, 'Successfully Open EBS after downloading', True)
        sendResponse()
        
    except Exception as e :
        take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
        setResponse(scriptParamId, 'Failed To Open EBS after downloading', False)
        sendResponse()
        raise Exception(e)

def ebsClickLink(xpath_param, path_to_screenhot, screenshot_file_name , scriptParamId):
    trycounter = 0
    while trycounter <  3 :
        try :
            trycounter += 1
            xpath = get_xpath(xpath_param,'link')
            _wait_until_element_is_found(xpath)
            xpath_field = selenium_driver.find_element_by_xpath(xpath)
            xpath_field.click()
            trycounter = 3
            time.sleep(2)
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'SuccessFully Clicked Link {xpath_param.split(">")[-1]}', True)
            sendResponse()
        except Exception as e :
            if trycounter < 3 : continue
            else : 
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed To Click Link {xpath_param.split(">")[-1]}', False)
                sendResponse()
                raise Exception(e)

def ebsButtonClick(xpath_param, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    while trycounter <  3 :
        try :
            trycounter += 1
            xpath = get_xpath(xpath_param,'button')
            _wait_until_element_is_found(xpath)
            xpath_field = selenium_driver.find_elements_by_xpath(xpath)
            print(xpath_field)
            xpath_field[0].click()
            trycounter = 3
            time.sleep(2)
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'SuccessFully Clicked The Button {xpath_param.split(">")[-1]}', True)
            sendResponse()
        except Exception as e :
            if trycounter < 3 : 
                continue
            else : 
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed To Click The Button {xpath_param.split(">")[-1]}', False)
                sendResponse()
                raise Exception(e)

def ebsClickBrowserRadioButton(xpath_param, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    while trycounter <  3 :
        try :
            trycounter += 1
            xpath = get_xpath(xpath_param, 'radio')
            _wait_until_element_is_found(xpath)
            xpath_field = selenium_driver.find_element_by_xpath(xpath)
            xpath_field.click()
            trycounter = 3
            time.sleep(2)
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'SuccessFully Clicked The Radio Button {xpath_param.split(">")[-1]}', True)
            sendResponse()
        except Exception as e :
            if trycounter < 3 : continue
            else : 
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed To Click The Radio Button {xpath_param.split(">")[-1]}', False)
                sendResponse()
                raise Exception(e)

def ebsSelectDropDown(xpath_param, value, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    while trycounter <  3 :
        try :
            trycounter += 1
            xpath = get_xpath(xpath_param, 'dropdown')
            _wait_until_element_is_found(xpath)
            xpath_field = Select(selenium_driver.find_element_by_xpath(xpath))
            if value != '' :
                xpath_field.select_by_visible_text(value)
            else :
                xpath_field.select_by_index(0)
            trycounter = 3
            time.sleep(2)
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'SuccessFully Selected The Dropdown {xpath_param.split(">")[-1]} with value {value}', True)
            sendResponse()
        except Exception as e :
            if trycounter < 3 : continue
            else : 
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed To Selected The Dropdown {xpath_param.split(">")[-1]} with value {value}', False)
                sendResponse()
                raise Exception(e)

def ebsBrowserEnterTextVal(xpath_param, value, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    while trycounter <  3 :
        try :
            trycounter += 1
            xpath = get_xpath(xpath_param, 'input')
            _wait_until_element_is_found(xpath)
            xpath_field = selenium_driver.find_element_by_xpath(xpath)
            _clear(xpath_field)
            xpath_field.send_keys(value)
            xpath_field.send_keys(Keys.TAB)
            trycounter = 3
            time.sleep(2)
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'SuccessFully Typed Into {xpath_param.split(">")[-1]} with value {value}', True)
            sendResponse()
        except Exception as e :
            if trycounter < 3 : continue
            else : 
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed To Type Into {xpath_param.split(">")[-1]} with value {value}', False)
                sendResponse()
                raise Exception(e)

def ebsInputTextEreaField(xpath_param, value, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    while trycounter <  3 :
        try :
            trycounter += 1
            xpath = get_xpath(xpath_param, 'textarea')
            _wait_until_element_is_found(xpath)
            xpath_field = selenium_driver.find_element_by_xpath(xpath)
            xpath_field.send_keys(value)
            trycounter = 3
            time.sleep(2)
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Failed To Type Into {xpath_param.split(">")[-1]} with value {value}', True)
            sendResponse()
        except Exception as e :
            if trycounter < 3 : continue
            else : 
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed To Type Into {xpath_param.split(">")[-1]} with value {value}', False)
                sendResponse()
                raise Exception(e)

def ebsEnterSearchTextField(xpath_param, value, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    try :
        trycounter += 1
        xpath = get_xpath(xpath_param, 'searchField')
        _wait_until_element_is_found(xpath)
        xpath_field = selenium_driver.find_element_by_xpath(xpath)
        xpath_field.send_keys(value)
        xpath_param1 = xpath_param.split('>')[-1]
        time.sleep(2)
        selenium_driver.find_element_by_xpath(f'{xpath}/following::img[@title="Search: {xpath_param1}"]').click()
        time.sleep(10)
        selenium_driver.switch_to_frame(f'Search and Select: {xpath_param1}')           
        selenium_driver.find_element_by_xpath('(//*[text()="Advanced Network Devices"]/preceding::input[@type="radio"])[1]').click() 
        ebsButtonClick('Select', path_to_screenhot, screenshot_file_name)
        selenium_driver.switch_to_default_content()
        trycounter = 3
        time.sleep(2)
        take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
        setResponse(scriptParamId, f'Failed To Type Into {xpath_param.split(">")[-1]} with value {value}', True)
        sendResponse()
    except Exception as e :
        take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
        setResponse(scriptParamId, f'Failed To Type Into {xpath_param.split(">")[-1]} with value {value}', False)
        sendResponse()
        raise Exception(e)


def ebsSwichFrame(xpath_param, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    global isFrameSwithed
    while trycounter <  3 :
        try :
            trycounter += 1
            xpath = get_xpath(xpath_param, 'frame')
            _wait_until_element_is_found(xpath)
            xpath_field = selenium_driver.find_element_by_xpath(xpath)
            selenium_driver.switch_to.frame(xpath_field)
            trycounter = 3
            time.sleep(2)
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Switched to Frame {xpath_param.split(">")[-1]}', True)
            sendResponse()
        except Exception as e :
            if trycounter < 3 : 
                continue
            else : 
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed To Switch To Frame {xpath_param.split(">")[-1]}', False)
                sendResponse()
                raise Exception(e)

def ebsSwitchToDefaultFrame(path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    while trycounter <  3 :
        try :
            trycounter += 1
            time.sleep(5)
            selenium_driver.switch_to.default_content()
            trycounter = 3
            time.sleep(2)
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Switched To Default Frame', True)
            sendResponse()
        except Exception as e :
            if trycounter < 3 : 
                continue
            else : 
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed To Switch To Default Frame', False)
                sendResponse()
                raise Exception(e)

def _wait_until_element_is_found(xpath_field):
    waitTime = 0
    
    while waitTime < 15 :
        try :
            waitTime += 1
            selenium_driver.find_element_by_xpath(xpath_field)
            waitTime = 15
        except Exception as e:
            # if waitTime < 15:
            time.sleep(1)
            continue
copiedValue = ''
def ebsCopyTextValue(xpath_param, path_to_screenhot, screenshot_file_name, scriptParamId):
    # copiedValue = ''
    trycounter = 0 
    while trycounter < 3 :
        try :
            xpath = get_xpath(xpath_param, 'b')
            _wait_until_element_is_found(xpath)
            xpath_fields = selenium_driver.find_elements_by_xpath(xpath)
            for field in xpath_fields :
                Text = field.text
                for text in list(Text.split()) :
                    if text.isnumeric() :
                        copiedValue = text
                        print(text)
                        break
            trycounter = 3
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Successfully Copied The Value', True, [xpath_param.split(">")[-1], copiedValue])
            sendResponse()
        except Exception as e :
            if trycounter < 3 : 
                continue
            else : 
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed To Copied The Value', False)
                sendResponse()
                raise Exception(e)
def ebsPasteTextValue(xpath_param, path_to_screenhot, screenshot_file_name, value = copiedValue):
    ebsBrowserEnterTextVal(xpath_param, value, path_to_screenhot, screenshot_file_name)

def _clear(xpath_field):
    try :
        xpath_field.clear()
    except :
        print('clear failed')
        pass

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

#get xpath as per requirement for ebs
def get_ebs_xpath( name, element, hasTable = False):
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
        elif element == 'menu' :
            XPATH =  f'//menu[@name=contains("{name}")]'
        else:
            print(element,name)
            raise Exception("Please provide valid element or name")
        print(XPATH)
        return XPATH
    except Exception as E :
        raise Exception(E)

# click push button
def ebsPushButtonClick(xpath_param, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = get_ebs_xpath(xpath_param, 'button')
            btn = driver.find_element_by_xpath(XPATH)
            btn.click()
            trycounter = 3
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Failed To Click Push Button {xpath_param}', True)
            sendResponse()
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed To Click Push Button {xpath_param}', False)
                sendResponse()
                raise Exception(exception)

#ebsEnterTextVal 
def ebsEnterTextVal(xpath_param, input_value, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = get_ebs_xpath(xpath_param, 'text')
            txtelement = driver.find_element_by_xpath(XPATH)
            txtelement.send_text(value=input_value, simulate=True)
            trycounter = 3
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Successfully Typed {input_value} into {xpath_param}', True)
            sendResponse()
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
                setResponse(scriptParamId, f'Failed To Typed {input_value} into {xpath_param}', False)
                sendResponse()
                raise Exception(exception)
    

#ebsClickCheckBox
def ebsClickCheckBox(xpath_param, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = get_ebs_xpath(xpath_param, 'checkbox')
            btn = driver.find_element_by_xpath(XPATH)
            btn.click()
            trycounter = 3
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Successfully clicked check box {xpath_param}', True)
            sendResponse()
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed To click check box {xpath_param}', False)
                sendResponse()
                raise Exception(exception)

#click radio button
def ebsClickRadioButton(xpath_param, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = get_ebs_xpath(xpath_param, 'radio')
            btn = driver.find_element_by_xpath(XPATH)
            btn.click()
            trycounter = 3
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Successfully clicked radio button {xpath_param}', True)
            sendResponse()
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed To Click Radio Button {xpath_param}', False)
                sendResponse()
                raise Exception(exception)

#ebs dropdown
def ebsClickDropDown(xpath_param, input_value, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = get_ebs_xpath(xpath_param, 'combobox')
            selectVal =  driver.find_element_by_xpath(XPATH)
            selectVal.select(option=input_value, simulate=True)   
            trycounter = 3
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Successfully clicked dropdown {xpath_param}', True)
            sendResponse()
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed to clicked dropdown {xpath_param}', False)
                sendResponse()
                raise Exception(exception)

#ebs dropdown
def ebsSelectMenu(xpath_param, input_value, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = get_ebs_xpath(xpath_param, 'menu')
            selectVal =  driver.find_element_by_xpath(XPATH)
            selectVal.select(option=input_value, simulate=True)   
            trycounter = 3
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Successfully select menu {xpath_param}', True)
            sendResponse()
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed to select menu {xpath_param}', False)
                sendResponse()
                raise Exception(exception)
#ebs save
def ebsSave():
    desktop.press_keys('ctrl','s')

#ebs Tab
def ebsTabKey():
    desktop.press_keys('tab')

#ebs enter
def ebsEnterKey():
    desktop.press_keys('enter')

#ebs down
def downKey():
    desktop.press_keys('down')


# select window and security changes
def ebsSelectWindow(xpath_param, path_to_screenhot, screenshot_file_name, scriptParamId):
    # xpath_param is application name
    try :
        _is_wait_cursor_complete()
        try :
            setDriver("Security Warning")
            checkbox = driver.find_element_by_xpath("//check box[@name=contains('I accept the risk and want to run this application')]")
            checkbox.click()
            runbtn = driver.find_element_by_xpath("//push button[@name=contains('Run')]")
            runbtn.click()
            _is_wait_cursor_complete()
            time.sleep(15)
            _is_wait_cursor_complete()
            time.sleep(15)
        except Exception as e :
            pass
        setDriver(xpath_param)
        _is_wait_cursor_complete()
        take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
        setResponse(scriptParamId, f'Success fully selected window {xpath_param}', True)
        sendResponse()
    except Exception as E :
        take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
        setResponse(scriptParamId, f'Failed to select window {xpath_param}', False)
        sendResponse()
        raise Exception(E)
        

#ebsClosePopUP
def ebsCloseWindow(path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            desktop.press_keys("ctrl","f4")
            time.sleep(5)
            trycounter = 3
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Successfully closed window', True)
            sendResponse()
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed to closed window', False)
                sendResponse()
                raise Exception(exception)

#CloseWindows
def ebsCloseWindows(path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            desktop.press_keys("f4")
            time.sleep(5)
            trycounter = 3
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Successfully closed  All windows', True)
            sendResponse()
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed to closed  All windows', False)
                sendResponse()
                raise Exception(exception)



#ebsExitApp
def ebsExitApp(path_to_screenhot, screenshot_file_name, scriptParamId):
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
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Successfully closed  Ebs Application', True)
            sendResponse()
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed to close Ebs Application', False)
                sendResponse()
                raise Exception(exception)


#ebsSelectTab
def ebsClickTab(xpath_param,input_value, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            XPATH = get_ebs_xpath(xpath_param, 'tab')
            selectVal =  driver.find_element_by_xpath(XPATH)
            selectVal.select(option=input_value, simulate=True)   
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Switch to tab {xpath_param}', True)
            sendResponse()
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed to Switch to tab {xpath_param}', False)
                sendResponse()
                raise Exception(exception)

#ebsCopyValue
def ebsCopyValue(xpath_param, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            setDriver()
            XPATH = get_ebs_xpath(xpath_param, 'text')
            txtelement = driver.find_element_by_xpath(XPATH)
            text = txtelement.text 
            trycounter = 3
            # return text  
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Successfully copied value from {xpath_param}', True, [xpath_param, text])
            sendResponse()
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed to copy value from {xpath_param}', False)
                sendResponse()
                raise Exception(exception)

def ebsPasteValue(xpath_param, input_value, path_to_screenhot, screenshot_file_name):
    ebsEnterTextVal(xpath_param, input_value, path_to_screenhot, screenshot_file_name)

def ebsStatusChange(xpath_param,button_name, path_to_screenhot, screenshot_file_name, scriptParamId):
    trycounter = 0
    _is_wait_cursor_complete()
    while trycounter < 3 :
        try :
            trycounter += 1
            _is_wait_cursor_complete()
            txt_one = getText(xpath_param)
            while True :
                txt_two = getText(xpath_param)
                if txt_one != txt_two or txt_two == 'Completed' : 
                    break
                driver = JABDriver(APPLICATION, PATH)
                logger.info("The JABDriver is initialized")
                refreshBtn = driver.find_element_by_xpath(f"//push button[@name=contains('{button_name}')]")
                refreshBtn.click()
                _is_wait_cursor_complete()
            trycounter = 3
            take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _passed)
            setResponse(scriptParamId, f'Successfully checked the status from {xpath_param}', True)
            sendResponse()
        except Exception as exception :
            if trycounter < 3 :
                _is_wait_cursor_complete()
                setDriver()
                continue
            else :
                take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name + _failed)
                setResponse(scriptParamId, f'Failed to checked the status from {xpath_param}', False)
                sendResponse()
                raise Exception(exception)

def getText(xpath_param):
    try :
        setDriver()
        XPATH = get_ebs_xpath(xpath_param, 'text')
        txtelement = driver.find_element_by_xpath(XPATH)
        text = txtelement.text 
        return text
    except : pass

try :
    """
        To provide all the required actions from steps.
    """
    pass
except Exception as exception :
    print("script got failed")

selenium_driver.close()
end_time = time.time()

print(f"it took {end_time - start_time} seconds")
    

path_to_screenhot, screenshot_file_name = 'C:\\Github\\EBS-Automation-POC\\Java_customization\\Selenium\\', '1.jpg'


