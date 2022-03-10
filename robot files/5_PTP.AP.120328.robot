*** Settings ***
Documentation    This File Will Be Used To Make The Desktop Automation
Library    RPA.Desktop
Library    RPA.Desktop.Windows
Library    RPA.Browser.Selenium
Library    OperatingSystem
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\EBS-Automation\\EBS Automation-POC\\Driver\\WindowsAccessBridge-64.dll
Library    Process
Library    Screenshot
Resource    CustomKeyWords.robot
*** Tasks ***
Go To EBS Invoice Page
    [Setup]    Set Selenium Implicit Wait    10
    [TearDown]    Capture And Upload Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum	5
    OperatingSystem.Create Directory    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum
    ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Call Method    ${chromeOptions}    add_argument    --start-maximized
    Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=C:\\EBS-Automation\\EBS Automation-POC\\Driver\\chromedriver.exe
    Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    Wait For Condition    return document.readyState == "complete" && document.title == "Login"    200
    Input Text    xpath=//*[@id="usernameField"]    gchockal
    Input Password    xpath=//*[@id="passwordField"]    welcome123
    Click Button When Visible    xpath=//button[text()="Log In"]
    Wait For Condition    return document.readyState == "complete" && document.title == "Home"    200
    RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\homepage.png
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_10_Invoice Creation_PTP.AP.120328_Test Run Lumentum_10_Passed.jpg
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Payables, Vision Operations (USA)"]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Invoices"]/parent::a//img[@title])[1]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Entry"]/parent::a//img[@title])[1]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Entry"]//following::div[text()="Invoices"][1])
    Sleep    4s
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_20_Invoice Creation_PTP.AP.120328_Test Run Lumentum_20_Passed.jpg
    RPA.Desktop.Press Keys    enter
    Sleep    10s
    RPA.Desktop.Press Keys    ctrl    j
    RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\dowloadpage.png
    Sleep    5s
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
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_30_Invoice Creation_PTP.AP.120328_Test Run Lumentum_30_Passed.jpg
    Run Keyword and Ignore Error    Call Element Action    Invoice Workbench    toggle maximized
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_40_Invoice Creation_PTP.AP.120328_Test Run Lumentum_40_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_60_Invoice Creation_PTP.AP.120328_Test Run Lumentum_60_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_70_Invoice Creation_PTP.AP.120328_Test Run Lumentum_70_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_80_Invoice Creation_PTP.AP.120328_Test Run Lumentum_80_Passed.jpg
    RPA.JavaAccessBridge.Type Text    PO Number    16875    clear=True
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_90_Invoice Creation_PTP.AP.120328_Test Run Lumentum_90_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_100_Invoice Creation_PTP.AP.120328_Test Run Lumentum_100_Passed.jpg
    RPA.JavaAccessBridge.Type Text    Invoice Date    04-MAR-2022
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_110_Invoice Creation_PTP.AP.120328_Test Run Lumentum_110_Passed.jpg
    RPA.JavaAccessBridge.Type Text    Invoice Num    16875    clear=True
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_120_Invoice Creation_PTP.AP.120328_Test Run Lumentum_120_Passed.jpg
    RPA.JavaAccessBridge.Type Text    Invoice Amount    5500
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_130_Invoice Creation_PTP.AP.120328_Test Run Lumentum_130_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    Match
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_140_Invoice Creation_PTP.AP.120328_Test Run Lumentum_140_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    Find
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_141_Invoice Creation_PTP.AP.120328_Test Run Lumentum_141_Passed.jpg
    RPA.JavaAccessBridge.Click Element    role|check box and name|Match
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_142_Invoice Creation_PTP.AP.120328_Test Run Lumentum_142_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    Match
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_190_Invoice Creation_PTP.AP.120328_Test Run Lumentum_190_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    Calculate Tax
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_200_Invoice Creation_PTP.AP.120328_Test Run Lumentum_200_Passed.jpg
    Application Refresh
    ${Total}=    Get And Save Element Value    Total    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum    Total
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_201_Invoice Creation_PTP.AP.120328_Test Run Lumentum_201_Passed.jpg
    RPA.JavaAccessBridge.Type Text    Invoice Amount    ${Total}    clear=True
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_202_Invoice Creation_PTP.AP.120328_Test Run Lumentum_202_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    Actions
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_210_Invoice Creation_PTP.AP.120328_Test Run Lumentum_210_Passed.jpg
    RPA.JavaAccessBridge.Click Element    role|check box and name|Validate
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_220_Invoice Creation_PTP.AP.120328_Test Run Lumentum_220_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    OK
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_221_Invoice Creation_PTP.AP.120328_Test Run Lumentum_221_Passed.jpg
    RPA.JavaAccessBridge.Select Menu    View    Request
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_222_Invoice Creation_PTP.AP.120328_Test Run Lumentum_222_Passed.jpg
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_223_Invoice Creation_PTP.AP.120328_Test Run Lumentum_223_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    Submit a New Request
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_224_Invoice Creation_PTP.AP.120328_Test Run Lumentum_224_Passed.jpg
    RPA.JavaAccessBridge.Type Text    Name    Create Accounting
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_225_Invoice Creation_PTP.AP.120328_Test Run Lumentum_225_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_226_Invoice Creation_PTP.AP.120328_Test Run Lumentum_226_Passed.jpg
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_227_Invoice Creation_PTP.AP.120328_Test Run Lumentum_227_Passed.jpg
    RPA.JavaAccessBridge.Type Text    Ledger    Vision Operations (USA)
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_228_Invoice Creation_PTP.AP.120328_Test Run Lumentum_228_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_229_Invoice Creation_PTP.AP.120328_Test Run Lumentum_229_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_230_Invoice Creation_PTP.AP.120328_Test Run Lumentum_230_Passed.jpg
    RPA.JavaAccessBridge.Type Text    End Date    04-MAR-22
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_231_Invoice Creation_PTP.AP.120328_Test Run Lumentum_231_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_232_Invoice Creation_PTP.AP.120328_Test Run Lumentum_232_Passed.jpg
    RPA.JavaAccessBridge.Type Text    Mode    Draft
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_233_Invoice Creation_PTP.AP.120328_Test Run Lumentum_233_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    OK
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_260_Invoice Creation_PTP.AP.120328_Test Run Lumentum_260_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    Submit
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_270_Invoice Creation_PTP.AP.120328_Test Run Lumentum_270_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    Yes
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_271_Invoice Creation_PTP.AP.120328_Test Run Lumentum_271_Passed.jpg
    RPA.Desktop.Press Keys    backspace
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_272_Invoice Creation_PTP.AP.120328_Test Run Lumentum_272_Passed.jpg
    RPA.JavaAccessBridge.Type Text    Name    Create Accounting
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_273_Invoice Creation_PTP.AP.120328_Test Run Lumentum_273_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_274_Invoice Creation_PTP.AP.120328_Test Run Lumentum_274_Passed.jpg
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_275_Invoice Creation_PTP.AP.120328_Test Run Lumentum_275_Passed.jpg
    RPA.JavaAccessBridge.Type Text    Ledger    Vision Operations (USA)
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_276_Invoice Creation_PTP.AP.120328_Test Run Lumentum_276_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_277_Invoice Creation_PTP.AP.120328_Test Run Lumentum_277_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_278_Invoice Creation_PTP.AP.120328_Test Run Lumentum_278_Passed.jpg
    RPA.JavaAccessBridge.Type Text    End Date    04-MAR-22
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_279_Invoice Creation_PTP.AP.120328_Test Run Lumentum_279_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_280_Invoice Creation_PTP.AP.120328_Test Run Lumentum_280_Passed.jpg
    RPA.JavaAccessBridge.Type Text    Mode    Final
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_281_Invoice Creation_PTP.AP.120328_Test Run Lumentum_281_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    OK
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_282_Invoice Creation_PTP.AP.120328_Test Run Lumentum_282_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    Submit
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_283_Invoice Creation_PTP.AP.120328_Test Run Lumentum_283_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    No
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_285_Invoice Creation_PTP.AP.120328_Test Run Lumentum_285_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    Find
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_290_Invoice Creation_PTP.AP.120328_Test Run Lumentum_290_Passed.jpg
    Wait For Element Status For Change    Phase    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_300_Invoice Creation_PTP.AP.120328_Test Run Lumentum_300_Passed.jpg
    RPA.Desktop.Press Keys    ctrl    s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_330_Invoice Creation_PTP.AP.120328_Test Run Lumentum_330_Passed.jpg
    RPA.Desktop.Press Keys    alt    f4
    Sleep    5s
    RPA.Desktop.Press Keys    enter
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Test Run Lumentum\\5_340_Invoice Creation_PTP.AP.120328_Test Run Lumentum_340_Passed.jpg
