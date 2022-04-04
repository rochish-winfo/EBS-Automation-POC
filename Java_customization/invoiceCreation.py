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
driver = JABDriver(APPLICATION, PATH)


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
    start_time = time.time()
    setDriver("Oracle Applications - EBSVIS")
    XPATH = f"//text[@name=contains('PO Number')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    txtelement.send_text(value="16689", simulate=True)
    logger.info(f"Typed 16689 into PO number")

    _is_wait_cursor_complete()
    XPATH = f"//text[@name=contains('Invoice Date')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    txtelement.send_text(value="11-MAR-2022", simulate=True)
    logger.info(f"Typed 11-MAR-2022 into Invoice Date")

    _is_wait_cursor_complete()
    XPATH = f"//text[@name=contains('Invoice Num')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    txtelement.send_text(value="PO-16883", simulate=True)
    logger.info(f"Typed PO-16883 into  Invoice Num")

    _is_wait_cursor_complete()
    XPATH = f"//text[@name=contains('Invoice Amount Required')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    txtelement.send_text(value="1000", simulate=True)
    logger.info(f"Typed 1000  into Invoice Amount Required ")

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('Match')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button Match")

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('Find')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button Find")

    _is_wait_cursor_complete()
    XPATH = f"//check box[@name=contains('Match')]"
    checkbox = driver.find_element_by_xpath(XPATH)
    checkbox.click()
    logger.info(f"Clicked Check Box Match")

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('Match')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button Match")

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('Calculate Tax')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button Calculate Tax")

    _is_wait_cursor_complete()
    XPATH = f"//text[@name=contains('Total')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    text = txtelement.text
    logger.info(f"Element Total has {text} text")

    _is_wait_cursor_complete()
    XPATH = f"//text[@name=contains('Invoice Amount Required')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    txtelement.send_text(value=text, simulate=True)
    logger.info(f"Typed {text} into  Invoice Amount Required")    

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('Actions')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button Actions")  

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('Actions')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button Actions")   

    _is_wait_cursor_complete()
    XPATH = f"//check box[@name=contains('Validate')]"
    checkbox = driver.find_element_by_xpath(XPATH)
    checkbox.click()
    logger.info(f"Clicked Check Box Validate")

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('OK')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button OK")

    _is_wait_cursor_complete()
    Menu = driver.find_element_by_xpath(f"//menu[@name=contains('View')]") 
    Request = driver.find_element_by_xpath(f"//menu item[@name=contains('Requests')]")
    Menu.click()
    logger.info(f"Clicked On Menu View")
    Request.click()
    logger.info(f"Clicked On Menu Item Requests")

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('Submit a New Request')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button Submit a New Request")

    _is_wait_cursor_complete()
    XPATH = f"//text[@name=contains('Name')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    txtelement.send_text(value="Create Accounting", simulate=True)
    logger.info(f"Typed Create Accounting into  Name")  

    _is_wait_cursor_complete()
    XPATH = f"//text[@name=contains('Ledger')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    txtelement.send_text(value="Vision Operations (USA)", simulate=True)
    logger.info(f"Typed Vision Operations (USA) into  Ledger") 

    _is_wait_cursor_complete()
    XPATH = f"//text[@name=contains('End Date')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    txtelement.send_text(value="11-MAR-22", simulate=True)
    logger.info(f"Typed 11-MAR-22 into  End Date") 

    _is_wait_cursor_complete()
    XPATH = f"//text[@name=contains('Mode')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    txtelement.send_text(value="Draft", simulate=True)
    logger.info(f"Typed Draft into  Mode") 

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('OK')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button OK")

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('Submit')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button Submit")

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('Yes')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button Yes")

    _is_wait_cursor_complete()
    XPATH = f"//text[@name=contains('Name')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    txtelement.send_text(value="Create Accounting", simulate=True)
    logger.info(f"Typed Create Accounting into  Name")  

    _is_wait_cursor_complete()
    XPATH = f"//text[@name=contains('Ledger')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    txtelement.send_text(value="Vision Operations (USA)", simulate=True)
    logger.info(f"Typed Vision Operations (USA) into  Ledger") 

    _is_wait_cursor_complete()
    XPATH = f"//text[@name=contains('End Date')]"
    txtelement = driver.find_element_by_xpath(XPATH)
    txtelement.send_text(value="11-MAR-22", simulate=True)
    logger.info(f"Typed 11-MAR-22 into  End Date") 

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('OK')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button OK")

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('Submit')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button Submit")

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('No')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button No")

    _is_wait_cursor_complete()
    XPATH = f"//push button[@name=contains('Find')]"
    btn = driver.find_element_by_xpath(XPATH)
    btn.click()
    logger.info(f"Clicked Push Button No")

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


    desktop.press_keys("ctrl","s")

    end_time = time.time()
    logger.info(f"The Execution completed in {end_time - start_time}")





