*** Settings ***
Documentation    This File Will Be Used To Make The Desktop Automation
Library    RPA.Desktop
Library    RPA.Desktop.Windows
Library    RPA.Browser.Selenium
Library    OperatingSystem
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=Driver\\WindowsAccessBridge-64.dll
Library    Process
Library    Screenshot
Resource    CustomKeyWords.robot
*** Tasks ***
Go To EBS Invoice Page
    [Setup]    Set Selenium Implicit Wait    10
    # [TearDown]    Capture And Upload Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum	2
    OperatingSystem.Create Directory    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum
    ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Call Method    ${chromeOptions}    add_argument    --start-maximized
    Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=Driver\\chromedriver.exe
    Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    Wait For Condition    return document.readyState == "complete" && document.title == "Login"    200
    Input Text    xpath=//*[@id="usernameField"]    gchockal
    Input Password    xpath=//*[@id="passwordField"]    welcome123
    Click Button When Visible    xpath=//button[text()="Log In"]
    Wait For Condition    return document.readyState == "complete" && document.title == "Home"    200
    RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\homepage.png
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\2_10_Requisition Summary_PTP.PO.20303_Test Run Lumentum_10_Passed.jpg
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Purchasing, Vision Operations (USA)"]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Requisitions"]/parent::a//img[@title])[1]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Requisition Summary"])[1]
    Sleep    8s
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\2_20_Requisition Summary_PTP.PO.20303_Test Run Lumentum_20_Passed.jpg
    RPA.Desktop.Press Keys    enter
    Sleep    15s
    RPA.Desktop.Press Keys    ctrl    j
    RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\dowloadpage.png
    Sleep    10s
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    enter
    Sleep    10s
    Run KeyWord and Ignore Error    Select Window    Security Warning
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Element    role|check box
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Push Button    Run
    Sleep    10s
    RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\ebsopen.png
    Select Window    Oracle Applications - EBSVIS
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\2_30_Requisition Summary_PTP.PO.20303_Test Run Lumentum_30_Passed.jpg
    RPA.JavaAccessBridge.Type Text    Requisition Number    16883    clear=True
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\2_40_Requisition Summary_PTP.PO.20303_Test Run Lumentum_40_Passed.jpg
    Ebs Click Button    Find
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\2_50_Requisition Summary_PTP.PO.20303_Test Run Lumentum_50_Passed.jpg
    RPA.Desktop.Press Keys    ctrl    s
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\2_60_Requisition Summary_PTP.PO.20303_Test Run Lumentum_60_Passed.jpg
    RPA.Desktop.Press Keys    f4
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\2_70_Requisition Summary_PTP.PO.20303_Test Run Lumentum_70_Passed.jpg
    RPA.Desktop.Press Keys    alt    f4
    Sleep    5s
    RPA.Desktop.Press Keys    enter
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\2_80_Requisition Summary_PTP.PO.20303_Test Run Lumentum_80_Passed.jpg
