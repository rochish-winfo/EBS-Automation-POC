from pyjab.jabdriver import JABDriver
from robot.api.deco import keyword
import logging
import time
import win32api as win32
import win32gui as win32gui
import win32con as win32con
import time
from RPA.Desktop import Desktop


APPLICATION = "Oracle Applications - EBSVIS"
PATH = "C:\\GitHub\\EBS-Automation-POC\\Driver\\WindowsAccessBridge-64.dll"
logger = logging.getLogger(__name__)
desktop = Desktop()

@keyword
def select_ebs_window(name : str = APPLICATION) -> None:
    _is_wait_cursor_complete()
    APPLICATION = name
    driver = JABDriver(name, PATH)
    logger.info("The JABDriver is initialized")
    # driver.expand()

@keyword
def ebs_click_button(name: str) -> None:
    _is_wait_cursor_complete()
    driver = JABDriver(APPLICATION, PATH)
    logger.info("The JABDriver is initialized")
    XPATH = f"//push button[@name=contains('{name}')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button {name}")

@keyword
def ebs_click_check_box(name : str = '') -> None :
    _is_wait_cursor_complete()
    driver = JABDriver(APPLICATION, PATH)
    logger.info("The JABDriver is initialized")
    XPATH = f"//check box[@name=contains('{name}')]"
    checkbox = driver.find_element_by_xpath(XPATH)
    checkbox.click()
    logger.info(f"Clicked Check Box {name}")

@keyword
def ebs_click_element(name : str = '') -> None :
    _is_wait_cursor_complete()
    driver = JABDriver(APPLICATION, PATH)
    logger.info("The JABDriver is initialized")
    # XPATH = f"//role[@name=contains('{name}')]"
    # checkbox = driver.find_element_by_xpath(XPATH)
    elm = driver.find_element_by_name(name)
    elm.click()
    logger.info(f"Clicked Element {name}")

@keyword
def ebs_type_text(name:str, value:str) -> None:
    _is_wait_cursor_complete()
    driver = JABDriver(APPLICATION, PATH)
    logger.info("The JABDriver is initialized")
    XPATH = f"//text[@name=contains('{name}')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    txtelement.send_text(value=value, simulate=True)
    logger.info(f"Typed {value} into {name}")


@keyword
def ebs_get_element_text(name:str) -> str :
    _is_wait_cursor_complete()
    # def get_element_text(name:str,reqvalue : str) -> tuple :
    driver = JABDriver(APPLICATION, PATH)
    logger.info("The JABDriver is initialized")
    XPATH = f"//text[@name=contains('{name}')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    text = txtelement.text
    logger.info(f"Element {name} has {text} text")
    # return (reqvalue, text)
    return text


@keyword
def ebs_close_pop_up(name: str) -> None:
    time.sleep(2)
    _is_wait_cursor_complete()
    desktop.press_keys("ctrl","f4")
    _is_wait_cursor_complete()

@keyword
def ebs_check_request_status(name : str) -> None:
    _is_wait_cursor_complete()
    txt_one = ebs_get_element_text(name)
    while True :
        txt_two = ebs_get_element_text(name)
        if txt_one != txt_two or txt_two == 'Completed' : 
            break
        driver = JABDriver(APPLICATION, PATH)
        logger.info("The JABDriver is initialized")
        refreshBtn = driver.find_element_by_xpath(f"//push button[@name=contains('Refresh Data')]")
        refreshBtn.click()
        _is_wait_cursor_complete()
    _is_wait_cursor_complete()


@keyword
def ebs_select_menu(menu: str, menu_item: str) -> None:
    _is_wait_cursor_complete()
    driver = JABDriver(APPLICATION, PATH)
    logger.info("The JABDriver is initialized")
    Menu = driver.find_element_by_xpath(f"//menu[@name=contains('{menu}')]") 
    Request = driver.find_element_by_xpath(f"//menu item[@name=contains('{menu_item}')]")
    Menu.click()
    logger.info(f"Clicked On Menu {menu}")
    Request.click()
    logger.info(f"Clicked On Menu Item {menu_item}")
    _is_wait_cursor_complete()


@keyword
def ebs_select_value(name : str , value : str ) -> None :
    _is_wait_cursor_complete()
    driver = JABDriver(APPLICATION, PATH)
    logger.info("The JABDriver is initialized")
    XPATH = f"//text[@name=contains('{name}')]"
    selectVal =  driver.find_element_by_xpath(XPATH)
    selectVal.select(option=value, simulate=True)    
    logger.info(f"Slected a {value} from dropdown {name}")
    _is_wait_cursor_complete()


def _is_wait_cursor_complete() :
    bool = 'False'
    start = time.time()
    while bool == 'False':
        hCursor = win32gui.SetCursor(win32gui.LoadCursor(0, win32con.IDC_WAIT))
        hCursor = win32gui.SetCursor(win32gui.LoadCursor(0, win32con.IDC_ARROW))
        currCur = win32gui.GetCursorInfo()[1]
        if hCursor !=currCur:
            bool = 'True'
    end = time.time()
    logger.info(f'Loading completed in {end - start}')


    

