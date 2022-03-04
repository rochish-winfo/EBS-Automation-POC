*** Settings ***
Library    RPA.Browser.Selenium
Library    RPA.Desktop
Library    Process
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\GitHub\\EBS-Automation-POC\\Driver\\WindowsAccessBridge-64.dll
Library    RPA.Desktop.Windows


Resource    CustomKeyWords.robot


*** Tasks ***
Create iProcurement Invoice
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
    RPA.Browser.Selenium.Input Text    xpath=//*[@id="usernameField"]    gchockal
    RPA.Browser.Selenium.Input Password    xpath=//*[@id="passwordField"]    welcome123
    RPA.Browser.Selenium.Click Button    xpath=//button[text()="Log In"]
    Sleep   5s
    Wait For Condition    return document.readyState == "complete"   200
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Payables, Vision Operations (USA)"]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Payables, Vision Operations (USA)"]//following::div[text()="Invoices"][1]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Payables, Vision Operations (USA)"]//following::div[text()="Invoices"][1]//following::div[text()="Entry"][1]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Payables, Vision Operations (USA)"]//following::div[text()="Invoices"][1]//following::div[text()="Entry"][1]//following::div[text()="Invoices"][1]
    Sleep    10s
    RPA.Desktop.Press Keys    enter  # Download The File
    Sleep    10s
    RPA.Desktop.Press Keys    ctrl    j    #Go To Download Page
    Sleep    10s
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    enter      
    Run KeyWord and Ignore Error    Select Window    Security Warning
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Element    role|check box   
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Push Button    Run
    Select Window    Oracle Applications - EBSVIS
    Call Element Action    Invoice Workbench    toggle maximized
    Application Refresh
    RPA.Desktop.Press Keys    tab     #go to taxpayer 
    RPA.Desktop.Press Keys    tab     #go to standard
    RPA.Desktop.Press Keys    tab     #go to PO number
    Application Refresh
    RPA.JavaAccessBridge.Type Text    PO Number    16802
    RPA.Desktop.Press Keys    tab    #load po number data
	RPA.JavaAccessBridge.Type Text    Invoice Date    03-MAR-2022
    RPA.JavaAccessBridge.Type Text    Invoice Num    PO-16802
    RPA.JavaAccessBridge.Type Text    Invoice Amount    1500
    RPA.JavaAccessBridge.Click Push Button    Match
    Application Refresh
    RPA.JavaAccessBridge.Click Push Button    Find
    Application Refresh
    # RPA.JavaAccessBridge.Click Element    role|check box and name|Match
    RPA.JavaAccessBridge.Click Push Button    Match        #click math 
    RPA.JavaAccessBridge.Click Push Button    Calculate Tax
    Application Refresh
    ${val}=    Get and Save Element Value    Total   C:\\GitHub\\EBS-Automation-POC\\robot files    Phase    #copy
    RPA.JavaAccessBridge.Type Text    Invoice Amount    ${val}    clear=True
    RPA.JavaAccessBridge.Click Push Button    Actions
    Application Refresh
    RPA.JavaAccessBridge.Click Element    role|check box and name|Validate
    RPA.JavaAccessBridge.Click Push Button    OK
    Application Refresh
    RPA.JavaAccessBridge.Select Menu    View    Request      #input will be View>Request from front end
    Application Refresh
    RPA.JavaAccessBridge.Click Push Button    Submit a New Request
    Application Refresh
    RPA.JavaAccessBridge.Type Text    Name    Create Accounting
    RPA.Desktop.Press Keys    tab    #load create accounting
    Application Refresh
    RPA.JavaAccessBridge.Type Text    Ledger    Vision Operations (USA)
    RPA.Desktop.Press Keys    tab    #load ledger
    RPA.Desktop.Press Keys    tab    #go to end date
    RPA.JavaAccessBridge.Type Text    End Date    03-MAR-22
    RPA.Desktop.Press Keys    tab     #go to mode
    RPA.JavaAccessBridge.Type Text    Mode    Draft
    RPA.Desktop.Press Keys    tab     #go to Errors Only
    RPA.Desktop.Press Keys    tab     #go to report
    RPA.Desktop.Press Keys    tab     #go to post in gerneral Ledger
    RPA.JavaAccessBridge.Click Push Button    OK
    Application Refresh
    RPA.JavaAccessBridge.Click Push Button    Submit
    Application Refresh
    RPA.JavaAccessBridge.Click Push Button    Yes
    Application Refresh
    RPA.Desktop.Press Keys    backspace
    RPA.JavaAccessBridge.Type Text    Name    Create Accounting
    RPA.Desktop.Press Keys    tab    #load create accounting
    Application Refresh
    RPA.JavaAccessBridge.Type Text    Ledger    Vision Operations (USA)
    RPA.Desktop.Press Keys    tab    #load ledger
    RPA.Desktop.Press Keys    tab    #go to end date
    RPA.JavaAccessBridge.Type Text    End Date    03-MAR-22
    RPA.Desktop.Press Keys    tab     #go to mode
    RPA.JavaAccessBridge.Type Text    Mode    Final
    RPA.Desktop.Press Keys    tab     #go to Errors Only
    RPA.Desktop.Press Keys    tab     #go to report
    RPA.Desktop.Press Keys    tab     #go to post in gerneral Ledger
    RPA.JavaAccessBridge.Click Push Button    OK
    Application Refresh
    RPA.JavaAccessBridge.Click Push Button    Submit
    Application Refresh   
    RPA.JavaAccessBridge.Click Push Button    No
    Application Refresh
    RPA.JavaAccessBridge.Click Push Button    Find
    Application Refresh
    Wait For Element Status For Change    Phase    C:\\GitHub\\EBS-Automation-POC\\robot files
    # ${text}=    RPA.JavaAccessBridge.Get Element Text    Request submitted
    RPA.Desktop.Press Keys    ctrl    s
    RPA.Desktop.Press Keys    alt    f4
    Sleep   5s
    RPA.Desktop.Press Keys    enter
