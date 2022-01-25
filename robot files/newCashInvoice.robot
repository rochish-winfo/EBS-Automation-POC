*** Settings ***
Documentation    This File Will Be Used To Make The Desktop Automation
Library    RPA.Desktop
Library    RPA.Desktop.Windows
Library    RPA.Browser.Selenium
Library    OperatingSystem
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=..\\Driver\\WindowsAccessBridge-64.dll
Library    Process

*** Tasks ***
Create Cash Invoice
    [Setup]    Set Selenium Speed    4 second
    ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=..\\Driver\\chromedriver.exe
    Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    Wait For Condition    return document.readyState == "complete" && document.title == "Login"    200
    RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Inovoice\\loginpage.png
    Input Text    xpath=//*[@id="usernameField"]    operations
    Input Password    xpath=//*[@id="passwordField"]    welcome
    Click Button    xpath=//button[text()="Log In"]
    Wait For Condition    return document.readyState == "complete" && document.title == "Home"    200
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Winfo AP Invoice Entry"]
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Invoices"]
    Sleep    4s
    RPA.Desktop.Press Keys    enter  # Download The File
    Sleep    10s
    RPA.Desktop.Press Keys    ctrl    j    #Go To Download Page
    Sleep    4s
    RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Inovoice\\downloaded.png
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    enter      
    Sleep    10s
    Run KeyWord and Ignore Error    Select Window    Security Warning
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Element    role:check box   
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Push Button    Run
    Sleep    10s
    RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Inovoice\\ebsinvoiceopen.png
    Select Window    Oracle Applications - EBSVIS
    Call Element Action    Invoice Workbench (Winfo AP Invoice Entry)    toggle maximized
    RPA.JavaAccessBridge.Type Text    Supplier Num    100106
	RPA.JavaAccessBridge.Type Text    Invoice Date    23-DEC-2021
    RPA.JavaAccessBridge.Type Text    Invoice Num    DEMO1--020
    RPA.JavaAccessBridge.Type Text    Invoice Amount    2000
    Sleep    5s
    RPA.JavaAccessBridge.Click Element    2 Lines
    Sleep    10s
    Application Refresh
    RPA.JavaAccessBridge.Type Text    Amount Required    1000    0
    RPA.JavaAccessBridge.Type Text    Description    A4 Paper    0
    RPA.Desktop.Press Keys    alt    f    n    #Create new row (this is same for every element as it is refereing to many item)
    RPA.JavaAccessBridge.Type Text    Amount Required    500    1
    RPA.JavaAccessBridge.Type Text    Description    A3 Paper    1
    RPA.Desktop.Press Keys    alt    f    n
    RPA.JavaAccessBridge.Type Text    Amount Required    500    2
    RPA.JavaAccessBridge.Type Text    Description    A2 Paper    2
    RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Inovoice\\invoiceCreated.png
    RPA.Desktop.Press Keys    ctrl    s    #save 
    RPA.Desktop.Press Keys    alt    f4    #exit
    RPA.Desktop.Press Keys    enter    #confirm exit


