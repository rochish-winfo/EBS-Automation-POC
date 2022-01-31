*** Settings ***

Library    RPA.Browser.Selenium
Library    RPA.Desktop
Library    Process
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\Program Files\\Java\\jdk-15.0.2\\bin\\windowsaccessbridge-64.dll
Library    RPA.Desktop.Windows

Resource    CustomKeyWords.robot

*** Tasks ***
Create Procure To Pay Invoice
    [Setup]    Set Selenium Speed    4 second
    ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=Driver\\chromedriver.exe
    Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    Wait For Condition    return document.readyState == "complete"
    RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Inovoice\\loginpage.png
    Input Text    xpath=//*[@id="usernameField"]    operations
    Input Password    xpath=//*[@id="passwordField"]    welcome
    Click Button    xpath=//button[text()="Log In"]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Winfo AP Invoice Entry"]
    Wait For Condition    return document.readyState == "complete"
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
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Element    role|check box   
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Push Button    Run
    Sleep    20s
    Select Window    Oracle Applications - EBSVIS
    Call Element Action    Invoice Workbench (Winfo AP Invoice Entry)    toggle maximized
    RPA.JavaAccessBridge.Type Text    PO NumberList of Values    200010010
    RPA.Desktop.Press Keys    tab    #load po number data
	RPA.JavaAccessBridge.Type Text    Invoice Date    23-DEC-2021
    RPA.JavaAccessBridge.Type Text    Invoice Num    DEMO-104
    RPA.JavaAccessBridge.Type Text    Invoice Amount    1000
    Sleep    5s
    RPA.JavaAccessBridge.Click Push Button    Match
    Application Refresh
    RPA.JavaAccessBridge.Type Text    Purchase Order: LineList of Values    1
    RPA.JavaAccessBridge.Click Push Button    Find
    Application Refresh
    RPA.JavaAccessBridge.Click Element    role|check box and name|Match
    RPA.JavaAccessBridge.Type Text    Qty Invoiced    10
    RPA.JavaAccessBridge.Type Text    Unit Price    50
    RPA.Desktop.Press Keys    tab    #Load match amount
    RPA.JavaAccessBridge.Click Push Button    Match        #click math 
    Application Refresh
    RPA.JavaAccessBridge.Click Push Button    Match    #clik on match will be same for every instance
    Application Refresh
    RPA.JavaAccessBridge.Type Text    Purchase Order: LineList of Values    2
    RPA.JavaAccessBridge.Click Push Button    Find
    Application Refresh
    RPA.JavaAccessBridge.Click Element    role|check box and name|Match
    RPA.JavaAccessBridge.Type Text    Qty Invoiced    10
    RPA.JavaAccessBridge.Type Text    Unit Price    50
    RPA.Desktop.Press Keys    tab    #Load match amount
    RPA.JavaAccessBridge.Click Push Button    Match
    RPA.JavaAccessBridge.Click Push Button    Calculate Tax
    Application Refresh
    ${totalAmount}=    RPA.JavaAccessBridge.Get Element Text    Total
    RPA.JavaAccessBridge.Type Text    Invoice Amount    ${totalAmount}    clear=True
    RPA.JavaAccessBridge.Click Push Button    Actions
    Application Refresh
    RPA.JavaAccessBridge.Click Element    role|check box and name|Validate
    RPA.JavaAccessBridge.Click Push Button    OK
    Sleep    20s
    Application Refresh
    RPA.JavaAccessBridge.Click Push Button    Actions
    Application Refresh
    RPA.JavaAccessBridge.Click Element    role|check box and name|Create Accounting
    RPA.JavaAccessBridge.Click Push Button    OK
    Sleep    20s
    RPA.Desktop.Press Keys    enter
    Application Refresh
    RPA.JavaAccessBridge.Click Push Button    Actions
    Application Refresh
    RPA.JavaAccessBridge.Click Element    role|check box and name|Create Accounting
    RPA.JavaAccessBridge.Click Element    role|radio button and name|Final Post
    RPA.JavaAccessBridge.Click Push Button    OK
    Sleep    10s
    RPA.Desktop.Press Keys    enter
    RPA.Desktop.Press Keys    ctrl    s
    RPA.Desktop.Press Keys    alt    f4
    RPA.Desktop.Press Keys    enter

