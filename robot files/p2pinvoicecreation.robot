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
    Sleep    20s
    Select Window    Oracle Applications - EBSVIS
    Print Element Tree    check1.txt
    Call Element Action    Invoice Workbench (Winfo AP Invoice Entry)    toggle maximized
    RPA.JavaAccessBridge.Type Text    Operating Unit    Vision Operations
    RPA.Desktop.Press Keys    tab    #go to customer tax payer id
    RPA.Desktop.Press Keys    tab    #go to Type
    RPA.Desktop.Press Keys    tab    #go to PO number
    RPA.JavaAccessBridge.Type Text    PO Number    200010010
    RPA.Desktop.Press Keys    tab    #load po number data
	RPA.JavaAccessBridge.Type Text    Invoice Date    23-DEC-2021
    RPA.JavaAccessBridge.Type Text    Invoice Num    DEMO-101
    RPA.JavaAccessBridge.Type Text    Invoice Amount    100
    Sleep    5s
    RPA.JavaAccessBridge.Click Push Button    Match
    Application Refresh
    Print Element Tree    check2.ext
    # Insert Line No For PO Invoice    1
    # Application Refresh
    # RPA.JavaAccessBridge.Click Push Button    Find
    # Application Refresh
    # Print Element Tree    check3.txt
    # RPA.JavaAccessBridge.Click Element    role:check box and name:Match
    # RPA.JavaAccessBridge.Type Text    Qty Invoiced    1
    # RPA.JavaAccessBridge.Type Text    Unit Price    50
    # RPA.Desktop.Press Keys    tab    #Load match amount
    # RPA.JavaAccessBridge.Click Push Button    Match        #click math 
    # Application Refresh
    # RPA.JavaAccessBridge.Click Push Button    Match    #clik on match will be same for every instance
    # Application Refresh
    # Insert Line No For PO Invoice    2
    # RPA.JavaAccessBridge.Click Push Button    Find
    # Application Refresh
    # RPA.JavaAccessBridge.Click Element    role:check box and name:Match
    # RPA.JavaAccessBridge.Type Text    Qty Invoiced    1
    # RPA.JavaAccessBridge.Type Text    Unit Price    50
    # RPA.Desktop.Press Keys    tab    #Load match amount
    # RPA.Desktop.Press Keys    alt    m

    

