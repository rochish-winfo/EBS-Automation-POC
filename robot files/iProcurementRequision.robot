*** Settings ***
Library    RPA.Browser.Selenium
Library    RPA.Desktop
Library    Process
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\GitHub\\EBS-Automation-POC\\Driver\\WindowsAccessBridge-64.dll
Library    RPA.Desktop.Windows


Resource    CustomKeyWords.robot


*** Tasks ***
Create iProcurement Requisition
    [Setup]    Set Selenium Implicit Wait    10   
    [TearDown]    Capture And Upload Screenshot    C:\\GitHub\\EBS-Automation-POC\\robot files
    ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=Driver\\chromedriver.exe
    Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    Sleep   5s
    Wait For Condition    return document.readyState == "complete"    200
    RPA.Browser.Selenium.Input Text    xpath=//*[@id="usernameField"]    operations
    RPA.Browser.Selenium.Input Password    xpath=//*[@id="passwordField"]    welcome
    RPA.Browser.Selenium.Click Button    xpath=//button[text()="Log In"]
    Sleep   5s
    Wait For Condition    return document.readyState == "complete"   200
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="iProcurement"]
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="iProcurement Home Page"]
    Wait For Condition    return document.readyState == "complete"   200
    RPA.Browser.Selenium.Click Link    xpath=//a[text()="Non-Catalog Request"]
    Wait For Condition    return document.readyState == "complete"   200
    RPA.Browser.Selenium.Click Element    xpath=//*[text()="Yes, I already have a specific supplier in mind"]
    RPA.Browser.Selenium.Click Button    xpath=//*[@title="Next"]
    Wait For Condition    return document.readyState == "complete"   200
    Sleep    4s
    RPA.Browser.Selenium.Select From List By Label    xpath=//select[@id="ItemType"]    Goods or Services.I can provide description and Total Amount
    sleep    4s
    RPA.Browser.Selenium.Input Text    xpath=//*[@id="ItemDescription"]    AMC
    sleep    4s
    RPA.Browser.Selenium.Input Text    xpath=//*[@id="Amount"]    1500
    sleep    4s
    RPA.Browser.Selenium.Input Text    xpath=//*[@id="Category"]    MISC.CONSULTING
    sleep    4s
    # RPA.Browser.Selenium.Click Element When Visible    xpath=//u[text()="MISC.CONSULTING"]     200
    RPA.Browser.Selenium.Input Text    xpath=//*[@id="SupplierOnNonCat"]    Advanced Network Devices
    # RPA.Browser.Selenium.Click Element When Visible    xpath=(//u[text()="Advanced Network Devices"])[1]    200
    # RPA.Browser.Selenium.Input Text    xpath=//input[@id="SupplierSiteOnNonCat"]    FRESNO
    # RPA.Browser.Selenium.Input Text    xpath=//*[@id="SupplierContact"]    Ackerman, Wendy
    # RPA.Browser.Selenium.Input Text    xpath=//*[@id="SupplierContactPhone"]    650 980-0728
    # RPA.Browser.Selenium.Press Keys    None    TAB
    # RPA.Browser.Selenium.Press Keys    None    ENTER
    Sleep    5s
    # ${v}=    Get Window Handles
    # RPA.Browser.Selenium.Switch Window    NEW
    RPA.Browser.Selenium.Select Frame     xpath=//*[@id="iframelovPopUp_SupplierOnNonCat"]
    RPA.Browser.Selenium.Click Element    xpath=//*[@id="N1:N10:1"]         #//span[@id='OASH__22118']/following::tr[1]/following::td[1]
    # RPA.Browser.Selenium.Click Element    xpath=//span[@id='OASH__22118']/following::tr[1]/following::td[1]
    RPA.Browser.Selenium.Click Button    xpath=//*[@id="lovBtnSelect"]
    # RPA.Browser.Selenium.Switch Window    MAIN
    RPA.Browser.Selenium.Unselect Frame
    RPA.Browser.Selenium.Click Button    xpath=//*[@id="AddToCart"]
    Wait For Condition    return document.readyState == "complete"   200
    Sleep    4s
    RPA.Browser.Selenium.Click Button    xpath=//*[@id="PopupCheckout"]
    RPA.Browser.Selenium.Select Frame     xpath=//*[@id="iframeShoppingCartPopup"]
    RPA.Browser.Selenium.Click Button    xpath=//button[@id="ShoppingPopupReview"]
    RPA.Browser.Selenium.Unselect Frame
    Wait For Condition    return document.readyState == "complete"   200
    RPA.Browser.Selenium.Click Button    xpath=//*[@id="Save"]
    Wait For Condition    return document.readyState == "complete"   200
    RPA.Browser.Selenium.Click Button    xpath=//*[@title="Continue with Checkout"]
    Wait For Condition    return document.readyState == "complete"   200
    RPA.Browser.Selenium.Click Button    xpath=//*[@id="Submit"]
    ${val}=    Get Element Value    xpath=//b[contains(text(),"Requisition ")]    C:\\GitHub\\EBS-Automation-POC\\robot files    Requisition







