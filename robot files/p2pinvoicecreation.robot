*** Settings ***

Library    RPA.Browser.Selenium
Library    RPA.Desktop
Library    Process
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\GitHub\\EBS-Automation-POC\\Driver\\WindowsAccessBridge-64.dll
Library    RPA.Desktop.Windows

# Resource    CustomKeyWords.robot

*** Tasks ***
Create Procure To Pay Invoice
    [Setup]    Set Selenium Implicit Wait    10 second
    ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=Driver\\chromedriver.exe
    Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    Maximize Browser Window
    Wait For Condition    return document.readyState == "complete"
    RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Inovoice\\loginpage.png
    Input Text    xpath=//*[@id="usernameField"]    gchockal
    Input Password    xpath=//*[@id="passwordField"]    welcome123
    Click Button    xpath=//button[text()="Log In"]
    Wait For Condition    return document.readyState == "complete"
    Sleep   5s
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
    RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Inovoice\\downloaded.png
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    enter      
    Run KeyWord and Ignore Error    Select Window    Security Warning
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Element    role|check box   
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Push Button    Run
    Select Window    Oracle Applications - EBSVIS
    Call Element Action    Invoice Workbench    toggle maximized
    Application Refresh
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    RPA.JavaAccessBridge.Type Text    PO Number    16596
    RPA.Desktop.Press Keys    tab    #load po number data
	RPA.JavaAccessBridge.Type Text    Invoice Date    14-FEB-2022
    RPA.JavaAccessBridge.Type Text    Invoice Num    PO-16596
    RPA.JavaAccessBridge.Type Text    Invoice Amount    1086
    # Sleep    5s
    RPA.JavaAccessBridge.Click Push Button    Match
    Application Refresh
    RPA.JavaAccessBridge.Type Text    Purchase Order: Line    1
    RPA.JavaAccessBridge.Type Text    Receipt Num    23727
    RPA.JavaAccessBridge.Click Push Button    Find
    Application Refresh
    RPA.JavaAccessBridge.Click Element    role|check box and name|Match
    RPA.JavaAccessBridge.Click Push Button    Match        #click math 
    RPA.JavaAccessBridge.Click Push Button    Calculate Tax
    RPA.JavaAccessBridge.Click Push Button    Actions
    Application Refresh
    RPA.JavaAccessBridge.Click Element    role|check box and name|Validate
    RPA.JavaAccessBridge.Click Push Button    OK
    Application Refresh
    RPA.JavaAccessBridge.Click Push Button    Actions
    Application Refresh
    RPA.JavaAccessBridge.Click Element    role|check box and name|Create Accounting
    RPA.JavaAccessBridge.Click Push Button    OK
    RPA.Desktop.Press Keys    enter
    Application Refresh
    RPA.JavaAccessBridge.Click Push Button    Actions
    Application Refresh
    RPA.JavaAccessBridge.Click Element    role|check box and name|Create Accounting
    RPA.JavaAccessBridge.Click Element    role|radio button and name|Final Post
    RPA.JavaAccessBridge.Click Push Button    OK
    RPA.Desktop.Press Keys    enter
    RPA.Desktop.Press Keys    ctrl    s
    RPA.Desktop.Press Keys    alt    f4
    Sleep   5s
    RPA.Desktop.Press Keys    enter
