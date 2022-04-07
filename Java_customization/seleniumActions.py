from cmath import e
from re import X
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
from RPA.Desktop import Desktop
from io import BytesIO
from PIL import Image, ImageFile, ImageGrab
import oci
import logging
from selenium.webdriver.support.ui import Select

logger = logging.getLogger(__name__)
desktop = Desktop()
chrome_driver_path = 'C:/Github/EBS-Automation-POC/Driver/chromedriver.exe'
url = 'http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp?'
username = 'gchockal'
password = 'welcome123'
# toNavigate = 'Purchasing, Vision Operations (USA)>Requisitions>Requisitions'
toNavigate = 'iProcurement>iProcurement Home Page'
isFrameSwithed = False
#defining chrome options
def options():
    options = webdriver.ChromeOptions()
    options.add_argument('--start-maximized')
    options.add_argument("--disable-gpu")
    options.add_argument("--disable-web-security")
    options.add_argument("--allow-running-insecure-content")
    options.add_experimental_option("prefs",{'download.prompt_for_download':True})
    return options

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




selenium_driver = webdriver.Chrome(executable_path=chrome_driver_path, options=options())
def ebsLogin(url, username, password, path_to_screenhot, screenshot_file_name):
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
            s =login_btn.click()
            print('Login button clicked ', s)
            # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
        except Exception as e :
            if trycounter < 3 : continue
            else : 
                # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(e)

def ebsSwitchWindow(name):
    desktop.press_keys('ctrl','w')
    # to be done generic
    # since we are using two driver so it is not particularly required now

def ebsNavigate(navigation, path_to_screenhot, screenshot_file_name):
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
                # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                time.sleep(2)
                trycounter = 3
        except Exception as e :
            if trycounter < 3 : continue
            else : 
                # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(e)

def openEbs():
    try :
        save_and_open_jnlp()
    except Exception as e :
        raise Exception('Failed To Open Jnlp after downloading')

def ebsClickLink(xpath_param, path_to_screenhot, screenshot_file_name):
    trycounter = 0
    while trycounter <  3 :
        try :
            trycounter += 1
            # selenium_driver.find_element_by_link_text(xpath_param).click()
            xpath = get_xpath(xpath_param,'link')
            _wait_until_element_is_found(xpath)
            xpath_field = selenium_driver.find_element_by_xpath(xpath)
            xpath_field.click()
            trycounter = 3
            # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            time.sleep(2)
        except Exception as e :
            if trycounter < 3 : continue
            else : 
                # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(e)

def ebsClickButton(xpath_param, path_to_screenhot, screenshot_file_name):
    trycounter = 0
    while trycounter <  3 :
        try :
            trycounter += 1
            xpath = get_xpath(xpath_param,'button')
            _wait_until_element_is_found(xpath)
            xpath_field = selenium_driver.find_elements_by_xpath(xpath)
            print(xpath_field)
            xpath_field[0].click()
            # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
            time.sleep(2)
        except Exception as e :
            if trycounter < 3 : 

                continue
            else : 
                
                # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(e)

def ebsChooseRadioButton(xpath_param, path_to_screenhot, screenshot_file_name):
    trycounter = 0
    while trycounter <  3 :
        try :
            trycounter += 1
            xpath = get_xpath(xpath_param, 'radio')
            _wait_until_element_is_found(xpath)
            xpath_field = selenium_driver.find_element_by_xpath(xpath)
            xpath_field.click()
            # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
            time.sleep(2)
        except Exception as e :
            if trycounter < 3 : continue
            else : 
                # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(e)

def ebsSelectDropDown(xpath_param, value, path_to_screenhot, screenshot_file_name):
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
                # xpath_field.deselect_all()
                # xpath_field.deselect_by_index(1)
                # xpath_field.select_by_value(value)
                xpath_field.select_by_index(0)
            # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
            time.sleep(2)
        except Exception as e :
            if trycounter < 3 : continue
            else : 
                # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(e)

def ebsInputTextField(xpath_param, value, path_to_screenhot, screenhot_file_name):
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
            # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
            time.sleep(2)
        except Exception as e :
            if trycounter < 3 : continue
            else : 
                # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(e)

def ebsInputTextEreaField(xpath_param, value, path_to_screenhot, screenhot_file_name):
    trycounter = 0
    while trycounter <  3 :
        try :
            trycounter += 1
            xpath = get_xpath(xpath_param, 'textarea')
            _wait_until_element_is_found(xpath)
            xpath_field = selenium_driver.find_element_by_xpath(xpath)
            xpath_field.send_keys(value)
            # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
            time.sleep(2)
        except Exception as e :
            if trycounter < 3 : continue
            else : 
                # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(e)

def ebsEnterSearchTextField(xpath_param, value, path_to_screenhot, screenshot_file_name):
    trycounter = 0
    # while trycounter <  3 :
    try :
        trycounter += 1
        xpath = get_xpath(xpath_param, 'searchField')
        _wait_until_element_is_found(xpath)
        xpath_field = selenium_driver.find_element_by_xpath(xpath)
        xpath_field.send_keys(value)
        time.sleep(2)
        selenium_driver.find_element_by_xpath(f'{xpath}/following::img[@title="Search: Supplier Name"]').click()
        # xpath_field.send_keys(Keys.TAB)
        # time.sleep(2)
        # print("entering")
        # xpath_field.send_keys(Keys.RETURN)
        # print("entered")
        time.sleep(10)
        # xpath_field.send_keys(Keys.TAB)
        # time.sleep(2)
        xpath_param1 = xpath_param.split('>')[-1]
        # frame = selenium_driver.find_element_by_xpath('//iframe[@id="iframelovPopUp_SupplierOnNonCat" and contains(@style,"visibility: visible")]')
        selenium_driver.switch_to_frame(f'Search and Select: {xpath_param1}')           #'iframelovPopUp_SupplierOnNonCat')            #//iframe[contains(@style,"visibility: visible")]')
        # selenium_driver.find_element_by_xpath(f'//*[text()=')  //*[text()="Search and Select: {xpath_param}"]'
        selenium_driver.find_element_by_xpath('(//*[text()="Advanced Network Devices"]/preceding::input[@type="radio"])[1]').click() # hardcoded as I am not able to find alternate solutions need to discuss
        # selenium_driver.find_element_by_xpath('//*[@id="lovBtnSelect"]').click()
        ebsClickButton('Select', path_to_screenhot, screenshot_file_name)
        selenium_driver.switch_to_default_content()
        # //*[text()="Search and Select: Supplier Name"]
        # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
        trycounter = 3
        time.sleep(2)
    except Exception as e :
        # if trycounter < 3 : continue
        # else : 
                # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
        raise Exception(e)


def ebsSwichFrame(xpath_param, path_to_screenhot, screenshot_file_name):
    trycounter = 0
    global isFrameSwithed
    while trycounter <  3 :
        try :
            # isFrameSwithed = True
            trycounter += 1
            xpath = get_xpath(xpath_param, 'frame')
            _wait_until_element_is_found(xpath)
            print(xpath)
            xpath_field = selenium_driver.find_element_by_xpath(xpath)
            print(xpath_field)
            selenium_driver.switch_to.frame(xpath_field)
            # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
            time.sleep(2)
        except Exception as e :
            if trycounter < 3 : 
                continue
            else : 
                # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(e)

def ebsSwitchToDefaultFrame(path_to_screenhot, screenshot_file_name):
    trycounter = 0
    while trycounter <  3 :
        try :
            trycounter += 1
            time.sleep(5)
            # selenium_driver.switch_to_default_content()
            selenium_driver.switch_to.default_content()
            # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
            trycounter = 3
            time.sleep(2)
        except Exception as e :
            if trycounter < 3 : 
                continue
            else : 
                # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
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
def ebsCopyTextValue(xpath_param, path_to_screenhot, screenshot_file_name):
    global copiedValue
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
            # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
        except :
            if trycounter < 3 : 
                continue
            else : 
                # take_screeshot_as_jpg(path_to_screenhot + screenshot_file_name)
                raise Exception(e)
def ebsPasteTextValue(xpath_param, path_to_screenhot, screenshot_file_name, value = copiedValue):
    ebsInputTextField(xpath_param, value, path_to_screenhot, screenshot_file_name)

def _clear(xpath_field):
    try :
        xpath_field.clear()
        # xpath_field.send_keys(Keys.CONTROL + 'A')
        # xpath_field.send_keys(Keys.BACKSPACE)
    except :
        print('clear failed')
        pass

path_to_screenhot, screenshot_file_name = 'C:\\Github\\EBS-Automation-POC\\Java_customization\\Selenium\\', '1.jpg'


ebsLogin(url, username, password, path_to_screenhot, screenshot_file_name)
# time.sleep(5)
ebsNavigate(toNavigate, path_to_screenhot, screenshot_file_name)
# time.sleep(5)
ebsClickLink('Shop>Non-Catalog Request', path_to_screenhot, screenshot_file_name)
# time.sleep(5)
ebsChooseRadioButton('Category Search>Yes, I already have a specific supplier in mind', path_to_screenhot, screenshot_file_name)
ebsClickButton('Category Search>Next', path_to_screenhot, screenshot_file_name)
# time.sleep(5)
ebsSelectDropDown("Non-Catalog Request>What do you need to request?", 'Goods or Services.I can provide description and Total Amount', path_to_screenhot, screenshot_file_name)
# time.sleep(10)
ebsInputTextEreaField('Non-Catalog Request>Item Description', 'AMC', path_to_screenhot, screenshot_file_name)
ebsInputTextField('Non-Catalog Request>Amount', '1500', path_to_screenhot, screenshot_file_name)
ebsInputTextField('Non-Catalog Request>Category', 'MISC.CONSULTING', path_to_screenhot, screenshot_file_name)
ebsEnterSearchTextField('Find your Supplier>Supplier Name', 'Advanced Network Devices', path_to_screenhot, screenshot_file_name)
ebsClickButton('Add to Cart', path_to_screenhot, screenshot_file_name)
# time.sleep(5)
ebsClickButton('Shopping Cart>View Cart and Checkout', path_to_screenhot, screenshot_file_name)
# time.sleep(5)
ebsSwichFrame('Shopping Cart', path_to_screenhot, screenshot_file_name)
ebsClickLink('Shopping Cart>Show Delivery and Billing', path_to_screenhot, screenshot_file_name)
# time.sleep(5)
ebsSelectDropDown('Billing>P-Card','',path_to_screenhot, screenshot_file_name)
# time.sleep(10)
ebsClickButton('Shopping Cart>Submit', path_to_screenhot, screenshot_file_name)
ebsSwitchToDefaultFrame(path_to_screenhot, screenshot_file_name)
# time.sleep(5)
requisition = ebsCopyTextValue('Requisition', path_to_screenhot, screenshot_file_name)
print(requisition)
selenium_driver.close()
# selenium_driver.

# //*[text()='Non-Catalog Request']/following::label[text()='What do you need to request?']/following::select[1]



# //b[contains(text(),'Requisition')]