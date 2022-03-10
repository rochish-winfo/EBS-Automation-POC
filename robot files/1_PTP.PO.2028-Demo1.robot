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
    # [Setup]    Set Selenium Implicit Wait    10
    # [TearDown]    Capture And Upload Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1	1
    # OperatingSystem.Create Directory    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1
    # ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    # ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    # Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    # Call Method    ${chromeOptions}    add_argument    --start-maximized
    # Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=Driver\\chromedriver.exe
    # Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    # Wait For Condition    return document.readyState == "complete" && document.title == "Login"    200
    # Input Text    xpath=//*[@id="usernameField"]    gchockal
    # Input Password    xpath=//*[@id="passwordField"]    welcome123
    # Click Button When Visible    xpath=//button[text()="Log In"]
    # Wait For Condition    return document.readyState == "complete" && document.title == "Home"    200
    # RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\homepage.png
    # Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_10_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_10_Passed.jpg
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=//div[text()="Purchasing, Vision Operations (USA)"]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Requisitions"]/parent::a//img[@title])[1]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Requisitions"]//following::div[text()="Requisitions"][2])
    # Sleep    8s
    # Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_15_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_15_Passed.jpg
    # RPA.Desktop.Press Keys    enter
    # Sleep    15s
    # RPA.Desktop.Press Keys    ctrl    j
    # RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\dowloadpage.png
    # Sleep    10s
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    enter
    # Sleep    10s
    # Run KeyWord and Ignore Error    Select Window    Security Warning
    # Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Element    role|check box
    # Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Push Button    Run
    # Sleep    10s
    RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\ebsopen.png
    Select Window    Oracle Applications - EBSVIS
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_20_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_20_Passed.jpg
    Ebs Type Text    Item    AS54888
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_25_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_25_Passed.jpg
    RPA.Desktop.Press Keys    down
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_30_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_30_Passed.jpg
    Ebs Type Text    Quantity    10
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_35_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_35_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_40_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_40_Passed.jpg
    Ebs Type Text    Price    100
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_45_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_45_Passed.jpg
    RPA.Desktop.Press Keys    tab
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_50_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_50_Passed.jpg
    Ebs Type Text    Need-By    15-Mar-22
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_55_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_55_Passed.jpg
    Ebs Type Text    Supplier    Advanced Network Devices
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_60_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_60_Passed.jpg
    Ebs Type Text    Site    FRESNO
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_65_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_65_Passed.jpg
    RPA.Desktop.Press Keys    ctrl    s
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_70_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_70_Passed.jpg
    ${Number}=    Get And Save Element Value    Number    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1    Number
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_75_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_75_Passed.jpg
    Ebs Click Button    Approve
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_80_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_80_Passed.jpg
    Ebs Click Button    OK
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_85_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_85_Passed.jpg
    RPA.Desktop.Press Keys    f4
    Sleep    4s
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_90_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_90_Passed.jpg
    RPA.Desktop.Press Keys    alt    f4
    Sleep    5s
    RPA.Desktop.Press Keys    enter
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\TestEbsP1\\1_95_Create Purchase Requisition_PTP.PO.2028-Demo1_TestEbsP1_95_Passed.jpg











    # ${passed} =    Run Keyword And Return Status    Click Push Button    OK
    # IF    ${passed} == ${FALSE}
    #     Log    ${passed}
    # END
    # ${passed} =    Run Keyword And Return Status    Click Push Button    Match
    # IF    ${passed} == ${TRUE}
    #     Log    ${passed}
    # END