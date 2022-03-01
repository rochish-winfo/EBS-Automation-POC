*** Settings ***
Documentation    This File Will Be Used To Make The Desktop Automation
Library    RPA.Desktop
Library    RPA.Desktop.Windows
Library    RPA.Browser.Selenium
Library    OperatingSystem
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\GitHub\\EBS-Automation-POC\\Driver\\WindowsAccessBridge-64.dll
Library    Process
Library    Screenshot
# Resource    CustomKeyWords.robot
*** Tasks ***
Go To EBS Invoice Page
    [Setup]    Set Selenium Implicit Wait    10
    # [TearDown]    Capture And Upload Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice
    # OperatingSystem.Create Directory    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice
    # ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    # ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    # Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    # Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=C:\\GitHub\\EBS-Automation-POC\\Driver\\chromedriver.exe
    # Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    # Wait For Condition    return document.readyState == "complete" && document.title == "Login"    200
    # Input Text    xpath=//*[@id="usernameField"]    operations
    # Input Password    xpath=//*[@id="passwordField"]    welcome
    # Click Button When Visible    xpath=//button[text()="Log In"]
    # Wait For Condition    return document.readyState == "complete" && document.title == "Home"    200
    # #RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\homepage.png
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_10_InvoiceCreation_PTP.AP.12030_EBSInvoice_10_Passed.jpg
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=//div[text()="Winfo AP Invoice Entry"]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Invoices"])[1]
    # Sleep    4s
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_20_InvoiceCreation_PTP.AP.12030_EBSInvoice_20_Passed.jpg
    # RPA.Desktop.Press Keys    enter
    # Sleep    10s
    # RPA.Desktop.Press Keys    ctrl    j
    # #RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\dowloadpage.png
    # Sleep    5s
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    enter
    # Sleep    20s
    # Run KeyWord and Ignore Error    Select Window    Security Warning
    # Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Element    role|check box
    # Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Push Button    Run
    # Sleep    20s
    # #RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\ebsopen.png
    Select Window    Oracle Applications - EBSVIS
    Application Refresh
    Print Element Tree    rpainvoice.txt
    #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_30_InvoiceCreation_PTP.AP.12030_EBSInvoice_30_Passed.jpg
    # Run Keyword and Ignore Error    Call Element Action    Invoice Workbench (Winfo AP Invoice Entry)    toggle maximized
    # Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_40_InvoiceCreation_PTP.AP.12030_EBSInvoice_40_Passed.jpg
    # RPA.Desktop.Press Keys    tab
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_60_InvoiceCreation_PTP.AP.12030_EBSInvoice_60_Passed.jpg
    # RPA.Desktop.Press Keys    tab
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_70_InvoiceCreation_PTP.AP.12030_EBSInvoice_70_Passed.jpg
    # RPA.Desktop.Press Keys    tab
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_80_InvoiceCreation_PTP.AP.12030_EBSInvoice_80_Passed.jpg
    # RPA.JavaAccessBridge.Type Text    PO Number    200010010
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_90_InvoiceCreation_PTP.AP.12030_EBSInvoice_90_Passed.jpg
    # RPA.Desktop.Press Keys    tab
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_100_InvoiceCreation_PTP.AP.12030_EBSInvoice_100_Passed.jpg
    # RPA.JavaAccessBridge.Type Text    Invoice Date    23-DEC-2021
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_110_InvoiceCreation_PTP.AP.12030_EBSInvoice_110_Passed.jpg
    # RPA.JavaAccessBridge.Type Text    Invoice Num    DEMO-065
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    tab
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_120_InvoiceCreation_PTP.AP.12030_EBSInvoice_120_Passed.jpg
    # RPA.JavaAccessBridge.Type Text    Invoice Amount    106
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_130_InvoiceCreation_PTP.AP.12030_EBSInvoice_130_Passed.jpg
    # RPA.JavaAccessBridge.Click Push Button    Match
    # Sleep    5s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_140_InvoiceCreation_PTP.AP.12030_EBSInvoice_140_Passed.jpg
    # RPA.JavaAccessBridge.Type Text    Purchase Order: LineList of Values    1
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_160_InvoiceCreation_PTP.AP.12030_EBSInvoice_160_Passed.jpg
    # RPA.JavaAccessBridge.Click Push Button    Find
    # Sleep    5s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_170_InvoiceCreation_PTP.AP.12030_EBSInvoice_170_Passed.jpg
    # RPA.JavaAccessBridge.Click Element    role|check box and name|Match
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_180_InvoiceCreation_PTP.AP.12030_EBSInvoice_180_Passed.jpg
    # RPA.JavaAccessBridge.Type Text    Qty Invoiced    5
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_190_InvoiceCreation_PTP.AP.12030_EBSInvoice_190_Passed.jpg
    # RPA.JavaAccessBridge.Type Text    Unit Price    10
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_200_InvoiceCreation_PTP.AP.12030_EBSInvoice_200_Passed.jpg
    # RPA.Desktop.Press Keys    tab
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_210_InvoiceCreation_PTP.AP.12030_EBSInvoice_210_Passed.jpg
    # RPA.JavaAccessBridge.Click Push Button    Match
    # Sleep    5s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_220_InvoiceCreation_PTP.AP.12030_EBSInvoice_220_Passed.jpg
    # RPA.JavaAccessBridge.Click Push Button    Match
    # Sleep    5s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_230_InvoiceCreation_PTP.AP.12030_EBSInvoice_230_Passed.jpg
    # RPA.JavaAccessBridge.Type Text    Purchase Order: LineList of Values    2
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_240_InvoiceCreation_PTP.AP.12030_EBSInvoice_240_Passed.jpg
    # RPA.JavaAccessBridge.Click Push Button    Find
    # Sleep    5s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_250_InvoiceCreation_PTP.AP.12030_EBSInvoice_250_Passed.jpg
    # RPA.JavaAccessBridge.Click Element    role|check box and name|Match
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_260_InvoiceCreation_PTP.AP.12030_EBSInvoice_260_Passed.jpg
    # RPA.JavaAccessBridge.Type Text    Qty Invoiced    5
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_270_InvoiceCreation_PTP.AP.12030_EBSInvoice_270_Passed.jpg
    # RPA.JavaAccessBridge.Type Text    Unit Price    10
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_280_InvoiceCreation_PTP.AP.12030_EBSInvoice_280_Passed.jpg
    # RPA.Desktop.Press Keys    tab
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_290_InvoiceCreation_PTP.AP.12030_EBSInvoice_290_Passed.jpg
    # RPA.JavaAccessBridge.Click Push Button    Match
    # Sleep    5s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_300_InvoiceCreation_PTP.AP.12030_EBSInvoice_300_Passed.jpg
    # RPA.JavaAccessBridge.Click Push Button    Calculate Tax
    # Sleep    5s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_310_InvoiceCreation_PTP.AP.12030_EBSInvoice_310_Passed.jpg
    # RPA.Desktop.Press Keys    tab
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_320_InvoiceCreation_PTP.AP.12030_EBSInvoice_320_Passed.jpg
    # RPA.JavaAccessBridge.Click Push Button    Actions
    # Sleep    5s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_330_InvoiceCreation_PTP.AP.12030_EBSInvoice_330_Passed.jpg
    # RPA.JavaAccessBridge.Click Element    role|check box and name|Validate
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_340_InvoiceCreation_PTP.AP.12030_EBSInvoice_340_Passed.jpg
    # RPA.JavaAccessBridge.Click Push Button    OK
    # Sleep    5s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_350_InvoiceCreation_PTP.AP.12030_EBSInvoice_350_Passed.jpg
    # RPA.Desktop.Press Keys    alt    f    n
    # Sleep    4s
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_360_InvoiceCreation_PTP.AP.12030_EBSInvoice_360_Passed.jpg
    # RPA.JavaAccessBridge.Click Push Button    Actions
    # Sleep    5s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_370_InvoiceCreation_PTP.AP.12030_EBSInvoice_370_Passed.jpg
    # RPA.JavaAccessBridge.Click Element    role|check box and name|Create Accounting
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_380_InvoiceCreation_PTP.AP.12030_EBSInvoice_380_Passed.jpg
    # RPA.JavaAccessBridge.Click Push Button    OK
    # Sleep    5s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_390_InvoiceCreation_PTP.AP.12030_EBSInvoice_390_Passed.jpg
    # RPA.Desktop.Press Keys    alt    f    n
    # Sleep    4s
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_400_InvoiceCreation_PTP.AP.12030_EBSInvoice_400_Passed.jpg
    # RPA.JavaAccessBridge.Click Push Button    OK
    # Sleep    5s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_410_InvoiceCreation_PTP.AP.12030_EBSInvoice_410_Passed.jpg
    # RPA.Desktop.Press Keys    enter
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_420_InvoiceCreation_PTP.AP.12030_EBSInvoice_420_Passed.jpg
    # RPA.JavaAccessBridge.Click Push Button    Actions
    # Sleep    5s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_430_InvoiceCreation_PTP.AP.12030_EBSInvoice_430_Passed.jpg
    # RPA.JavaAccessBridge.Click Element    role|check box and name|Create Accounting
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_440_InvoiceCreation_PTP.AP.12030_EBSInvoice_440_Passed.jpg
    # RPA.JavaAccessBridge.Click Element    role|radio button and name|Final Post
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_450_InvoiceCreation_PTP.AP.12030_EBSInvoice_450_Passed.jpg
    # RPA.JavaAccessBridge.Click Push Button    OK
    # Sleep    5s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_460_InvoiceCreation_PTP.AP.12030_EBSInvoice_460_Passed.jpg
    # RPA.Desktop.Press Keys    alt    f    n
    # Sleep    4s
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_470_InvoiceCreation_PTP.AP.12030_EBSInvoice_470_Passed.jpg
    # RPA.Desktop.Press Keys    enter
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_480_InvoiceCreation_PTP.AP.12030_EBSInvoice_480_Passed.jpg
    # RPA.Desktop.Press Keys    ctrl    s
    # Application Refresh
    # #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_490_InvoiceCreation_PTP.AP.12030_EBSInvoice_490_Passed.jpg
    # RPA.Desktop.Press Keys    alt    f4
    # Sleep    5s
    # RPA.Desktop.Press Keys    enter
    #Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\ebs\\WATS\\EBSInvoice\\3_500_InvoiceCreation_PTP.AP.12030_EBSInvoice_500_Passed.jpg
