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
driver = JABDriver(APPLICATION, PATH)
logger = logging.getLogger(__name__)
desktop = Desktop()
LOV = "List of Values"


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
    setDriver()


def setDriver(name = APPLICATION):
    driver = JABDriver(name, PATH)
    logger.info("The JABDriver is initialized")


if __name__ == '__main__':
    try:
        startTime = time.time()
        _is_wait_cursor_complete()
        #type text to reciept methond
        XPATH = f"//text[@name=contains('Receipt Method')]"
        txtelement = driver.find_element_by_xpath(XPATH)
        txtelement.send_text(value="Manual Remittance", simulate=True)
        if LOV in txtelement.name :
            desktop.press_keys("down")
        logger.info(f"Typed Manual Remittance into Receipt Method")

        #press key tab to load the remittance
        desktop.press_keys("tab")

        _is_wait_cursor_complete()
        #type text to Receipt Number
        XPATH = f"//text[@name=contains('Receipt Number')]"
        txtelement = driver.find_element_by_xpath(XPATH)
        txtelement.send_text(value="DEMO-0001", simulate=True)
        logger.info(f"Typed DEMO-0001 into Receipt Number")

        # desktop.press_keys("tab")
        # desktop.press_keys("tab")
        # desktop.press_keys("tab")
        _is_wait_cursor_complete()
        #type text to Receipt Amount
        XPATH = f"//text[@name='Receipt Amount Required'  and @indexinparent=7]"
        txtelement = driver.find_element_by_xpath(XPATH)
        txtelement.send_text(value="1000", simulate=True)
        logger.info(f"Typed 1000 into Receipt Amount Required")

        _is_wait_cursor_complete()
        #type text to Receipt Amount
        XPATH = f"//text[@description='NameList of Values']"
        txtelement = driver.find_element_by_xpath(XPATH)
        txtelement.send_text(value="Global Enterprises", simulate=True)
        logger.info(f"Typed OC Medical Center into NameList of Values")


       # press key tab to load the remittance
        desktop.press_keys("tab")

        _is_wait_cursor_complete()
        #click push button search
        XPATH = f"//push button[@name=contains('Search')]"
        btn = driver.find_element_by_xpath(XPATH)
        btn.click()
        logger.info(f"Clicked Push Button Search")


        _is_wait_cursor_complete()
        #click push button apply
        XPATH = f"//push button[@name=contains('Apply')]"
        btn = driver.find_element_by_xpath(XPATH)
        btn.click()
        logger.info(f"Clicked Push Button Apply")

        #save
        # desktop.press_keys("ctrl","s")
        endTime = time.time()

        logger.info(f"Execution Completed In {endTime - startTime} seconds")
    except Exception as e :
        print(e)


