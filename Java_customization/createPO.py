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
        raise TimeoutError("no java window found by title 'Oracle Applications - EBSVIS' in '30'seconds")


if __name__ == '__main__':
    try :
        _is_wait_cursor_complete()
        setDriver("Oracle Applications - EBSVIS")

        #type Item
        try : 
            _is_wait_cursor_complete()
            XPATH = f"//text[@name=contains('Item')]"
            txtelement = driver.find_element_by_xpath(XPATH)
            txtelement.send_text(value="AS54888", simulate=True)
            logger.info(f"Typed AS54888 into Item")
            if LOV in txtelement.name :
                desktop.press_keys("down")
                logger.info(f"Down Key is pressed to load the input")
        except :
            try :
                setDriver()
                logger.info("Come to Exception for Item")
                XPATH = f"//text[@name=contains('Item')]"
                txtelement = driver.find_element_by_xpath(XPATH)
                txtelement.send_text(value="AS54888", simulate=True)
                logger.info(f"Typed AS54888 into Item")
                if LOV in txtelement.name :
                    desktop.press_keys("down")
                    logger.info(f"Down Key is pressed to load the input")
            except :
                raise Exception("Unable to type")

        #type quantity
        try : 
            _is_wait_cursor_complete()
            XPATH = f"//text[@name=contains('Quantity')]"
            txtelement = driver.find_element_by_xpath(XPATH)
            txtelement.send_text(value="10", simulate=True)
            logger.info(f"Typed 10 into Quantity")
            if LOV in txtelement.name :
                desktop.press_keys("down")
                logger.info(f"Down Key is pressed to load the input")
        except :
            try :
                setDriver()
                logger.info("Come to Exception for Quantity")
                XPATH = f"//text[@name=contains('Quantity')]"
                txtelement = driver.find_element_by_xpath(XPATH)
                txtelement.send_text(value="10", simulate=True)
                logger.info(f"Typed 10 into Quantity")
                if LOV in txtelement.name :
                    desktop.press_keys("down")
                    logger.info(f"Down Key is pressed to load the input")
            except :
                raise Exception("Unable to type")

        #type Price
        try : 
            _is_wait_cursor_complete()
            XPATH = f"//text[@name=contains('Price')]"
            txtelement = driver.find_element_by_xpath(XPATH)
            txtelement.send_text(value="100", simulate=True)
            logger.info(f"Typed 100 into Price")
            if LOV in txtelement.name :
                desktop.press_keys("down")
                logger.info(f"Down Key is pressed to load the input")
        except :
            try :
                setDriver()
                logger.info("Come to Exception for Price")
                XPATH = f"//text[@name=contains('Price')]"
                txtelement = driver.find_element_by_xpath(XPATH)
                txtelement.send_text(value="100", simulate=True)
                logger.info(f"Typed 100 into Price")
                if LOV in txtelement.name :
                    desktop.press_keys("down")
                    logger.info(f"Down Key is pressed to load the input")
            except :
                raise Exception("Unable to type")

        #type Need-By
        try : 
            _is_wait_cursor_complete()
            XPATH = f"//text[@name=contains('Need-By')]"
            txtelement = driver.find_element_by_xpath(XPATH)
            txtelement.send_text(value="31-Mar-22", simulate=True)
            logger.info(f"Typed 31-MAR-22 into Need-By")
            if LOV in txtelement.name :
                desktop.press_keys("down")
                logger.info(f"Down Key is pressed to load the input")
        except :
            try :
                setDriver()
                logger.info("Come to Exception for Need-By")
                XPATH = f"//text[@name=contains('Need-By')]"
                txtelement = driver.find_element_by_xpath(XPATH)
                txtelement.send_text(value="31-Mar-22", simulate=True)
                logger.info(f"Typed 31-Mar-22 into Need-By")
                if LOV in txtelement.name :
                    desktop.press_keys("down")
                    logger.info(f"Down Key is pressed to load the input")
            except :
                raise Exception("Unable to type Need-By")

        #type supplier
        try : 
            _is_wait_cursor_complete()
            XPATH = f"//text[@name=contains('Supplier')]"
            txtelement = driver.find_element_by_xpath(XPATH)
            txtelement.send_text(value="Advanced Network Devices", simulate=True)
            logger.info(f"Typed Advanced Network Devices into Supplier")
            if LOV in txtelement.name :
                desktop.press_keys("down")
                logger.info(f"Down Key is pressed to load the input")
        except :
            try :
                setDriver()
                XPATH = f"//text[@name=contains('Supplier')]"
                txtelement = driver.find_element_by_xpath(XPATH)
                txtelement.send_text(value="Advanced Network Devices", simulate=True)
                logger.info(f"Typed Advanced Network Devices into Supplier")
                if LOV in txtelement.name :
                    desktop.press_keys("down")
                    logger.info(f"Down Key is pressed to load the input")
            except :
                raise Exception("Unable to type Supplier")

        #type Site
        try : 
            _is_wait_cursor_complete()
            XPATH = f"//text[@name=contains('Site')]"
            txtelement = driver.find_element_by_xpath(XPATH)
            txtelement.send_text(value="FRESNO", simulate=True)
            logger.info(f"Typed FRESNO into Site")
            if LOV in txtelement.name :
                desktop.press_keys("down")
                logger.info(f"Down Key is pressed to load the input")
        except :
            try :
                setDriver()
                logger.info("Come to Exception for Site")
                XPATH = f"//text[@name=contains('Site')]"
                txtelement = driver.find_element_by_xpath(XPATH)
                txtelement.send_text(value="FRESNO", simulate=True)
                logger.info(f"Typed FRESNO into Site")
                if LOV in txtelement.name :
                    desktop.press_keys("down")
                    logger.info(f"Down Key is pressed to load the input")
            except :
                raise Exception("Unable to type Site")

        
        
    except Exception as e:
        print("Exception Occured ", e)

