from pyjab.jabdriver import JABDriver
from robot.api.deco import keyword
import logging
import time
import win32api as win32
import win32gui as win32gui
import win32con as win32con
import time

APPLICATION = "Oracle Applications - EBSVIS"
PATH = "C:\GitHub\EBS-Automation-POC\Driver\WindowsAccessBridge-64.dll"
logger = logging.getLogger(__name__)


@keyword
def select_java_window(name : str = APPLICATION) -> None:
    _is_wait_cursor_complete()
    APPLICATION = name
    driver = JABDriver(name, PATH)
    logger.info("The JABDriver is initialized")

@keyword
def click_button(name: str) -> None:
    _is_wait_cursor_complete()
    driver = JABDriver(APPLICATION)
    logger.info("The JABDriver is initialized")
    XPATH = f"//push button[@name=contains('{name}')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button {name}")

@keyword
def click_check_box(name : str = '') -> None :
    _is_wait_cursor_complete()
    driver = JABDriver(APPLICATION)
    logger.info("The JABDriver is initialized")
    XPATH = f"//check box[@name=contains('{name}')]"
    checkbox = driver.find_element_by_xpath(XPATH)
    checkbox.click()
    logger.info(f"Clicked Check Box {name}")

@keyword
def type_text(name:str, value:str) -> None:
    _is_wait_cursor_complete()
    driver = JABDriver(APPLICATION)
    logger.info("The JABDriver is initialized")
    XPATH = f"//text[@name=contains('{name}')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    txtelement.send_text(value=value, simulate=True)
    logger.info(f"Typed {value} into {name}")


@keyword
def get_element_text(name:str) -> str :
    _is_wait_cursor_complete()
    # def get_element_text(name:str,reqvalue : str) -> tuple :
    driver = JABDriver(APPLICATION)
    logger.info("The JABDriver is initialized")
    XPATH = f"//text[@name=contains('{name}')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    text = txtelement.text
    logger.info(f"Element {name} has {text} text")
    # return (reqvalue, text)
    return text


def _is_wait_cursor_complete() :
    bool = 'False'
    time.sleep(2)
    start = time.time()
    while bool == 'False':
        hCursor = win32gui.SetCursor(win32gui.LoadCursor(0, win32con.IDC_WAIT))
        hCursor = win32gui.SetCursor(win32gui.LoadCursor(0, win32con.IDC_ARROW))
        currCur = win32gui.GetCursorInfo()[1]
        if hCursor !=currCur:
            bool = 'True'
    end = time.time()
    logger.info(f'Loading completed in {end - start}')
    

