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
    RPA.Browser.Selenium.Click Link    xpath=//a[text()="Receiving"]
    RPA.Browser.Selenium.Click Link    xpath=(//span[text()="16802"]//following::a)[1]
    Wait For Condition    return document.readyState == "complete"   200
    RPA.Browser.Selenium.Click Button    xpath=//button[@id="SubmitButton"]
    ${val}=    Get Element Value    xpath=//b[contains(text()," Receipt ")]    C:\\GitHub\\EBS-Automation-POC\\robot files    Receipt