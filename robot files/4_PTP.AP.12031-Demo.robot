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
    [TearDown]    Capture And Upload Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6	4
    OperatingSystem.Create Directory    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6
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
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_10_Receivables_PTP.AP.12031-Demo_Dep check 6_10_Passed.jpg
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Inventory, Vision Operations (USA)"]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Transactions"]/parent::a//img[@title])[1]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Receiving"]/parent::a//img[@title])[1]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Receipts"])[1]
    Sleep    4s
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_20_Receivables_PTP.AP.12031-Demo_Dep check 6_20_Passed.jpg
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
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_30_Receivables_PTP.AP.12031-Demo_Dep check 6_30_Passed.jpg
    RPA.Desktop.Press Keys    shift    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_40_Receivables_PTP.AP.12031-Demo_Dep check 6_40_Passed.jpg
    RPA.Desktop.Press Keys    backspace
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_50_Receivables_PTP.AP.12031-Demo_Dep check 6_50_Passed.jpg
    RPA.JavaAccessBridge.Type Text    Find    M1
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_60_Receivables_PTP.AP.12031-Demo_Dep check 6_60_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    Find
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_70_Receivables_PTP.AP.12031-Demo_Dep check 6_70_Passed.jpg
    RPA.JavaAccessBridge.Type Text    Purchase Order    16673    clear=True
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_80_Receivables_PTP.AP.12031-Demo_Dep check 6_80_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    Find
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_90_Receivables_PTP.AP.12031-Demo_Dep check 6_90_Passed.jpg
    Sleep    10s
    Call Element Action    Receipt Header    close window
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_100_Receivables_PTP.AP.12031-Demo_Dep check 6_100_Passed.jpg
    RPA.JavaAccessBridge.Click Element    role|check box
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_110_Receivables_PTP.AP.12031-Demo_Dep check 6_110_Passed.jpg
    RPA.Desktop.Press Keys    enter
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_120_Receivables_PTP.AP.12031-Demo_Dep check 6_120_Passed.jpg
    RPA.JavaAccessBridge.Click Element    Description
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_130_Receivables_PTP.AP.12031-Demo_Dep check 6_130_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_140_Receivables_PTP.AP.12031-Demo_Dep check 6_140_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_150_Receivables_PTP.AP.12031-Demo_Dep check 6_150_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_160_Receivables_PTP.AP.12031-Demo_Dep check 6_160_Passed.jpg
    RPA.JavaAccessBridge.Type Text    Subinventory    FGI
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_170_Receivables_PTP.AP.12031-Demo_Dep check 6_170_Passed.jpg
    RPA.Desktop.Press Keys    ctrl    s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_180_Receivables_PTP.AP.12031-Demo_Dep check 6_180_Passed.jpg
    RPA.JavaAccessBridge.Click Push Button    Header
    Sleep    5s
    Application Refresh
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_190_Receivables_PTP.AP.12031-Demo_Dep check 6_190_Passed.jpg
    Application Refresh
    ${Receipt}=    Get And Save Element Value    Receipt    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6    Receipt
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_200_Receivables_PTP.AP.12031-Demo_Dep check 6_200_Passed.jpg
    RPA.Desktop.Press Keys    alt    f4
    Sleep    5s
    RPA.Desktop.Press Keys    enter
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\Dep check 6\\4_210_Receivables_PTP.AP.12031-Demo_Dep check 6_210_Passed.jpg
