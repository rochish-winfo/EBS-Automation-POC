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
    [TearDown]    Capture And Upload Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum	3
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
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_10_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_10_Passed.jpg
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Purchasing, Vision Operations (USA)"]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="AutoCreate"])[1]
    Sleep    10s
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_15_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_15_Passed.jpg
    RPA.Desktop.Press Keys    enter
    Sleep    10s
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
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_20_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_20_Passed.jpg
    Ebs Click Button    Clear
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_25_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_25_Passed.jpg
    Ebs Type Text    Requisition    16883
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_30_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_30_Passed.jpg
    Ebs Click Button    Find
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_35_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_35_Passed.jpg
    RPA.JavaAccessBridge.Click Element    role|check box
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_40_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_40_Passed.jpg
    Ebs Click Button    Automatic
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_45_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_45_Passed.jpg
    Ebs Type Text    Document    16883
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_50_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_50_Passed.jpg
    Ebs Click Button    Create
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_55_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_55_Passed.jpg
    RPA.Desktop.Press Keys    ctrl    s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_60_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_60_Passed.jpg
    Sleep    7s
    RPA.Desktop.Press Keys    f4
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_65_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_65_Passed.jpg
    RPA.Desktop.Press Keys    alt    f4
    Sleep    5s
    RPA.Desktop.Press Keys    enter
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_70_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_70_Passed.jpg
    RPA.Desktop.Press Keys    ctrl    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_75_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_75_Passed.jpg
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Buyer Work Center"]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Orders"])[1]
    Sleep    4s
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_80_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_80_Passed.jpg
    RPA.Browser.Selenium.Select From List By Label    xpath=//select[@id="ActionsPoplist"]   Update
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_85_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_85_Passed.jpg
    RPA.Browser.Selenium.Click Button    xpath=//button[@id="GoButton"]
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_90_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_90_Passed.jpg
    RPA.Browser.Selenium.Click Button    xpath=//button[@id="SubmitButton"]
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\3_95_PR to PO Generation_PTP.PO.20304_Test Run Lumentum_95_Passed.jpg