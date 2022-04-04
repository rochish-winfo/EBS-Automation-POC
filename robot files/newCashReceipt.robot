*** Settings ***
Documentation    This File Will Be Used To Make The Desktop Automation
Library    RPA.Desktop
Library    RPA.Desktop.Windows
Library    RPA.Browser.Selenium
Library    OperatingSystem
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=Driver\\WindowsAccessBridge-64.dll
Library    Process

*** Tasks ***
Create Cash Receipt
    # [Setup]    Set Selenium Speed    4 second
    # ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    # ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    # Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    # Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=..\\Driver\\chromedriver.exe
    # Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    # # Open Browser    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp    ie    executable_path=Driver\\IEDriverServer.exe
    # Wait For Condition    return document.readyState == "complete" && document.title == "Login"    20
    # RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\loginpage.png
    # Input Text    xpath=//*[@id="usernameField"]    operations
    # Input Password    xpath=//*[@id="passwordField"]    welcome
    # Click Button    xpath=//button[text()="Log In"]
    # Wait For Condition    return document.readyState == "complete" && document.title == "Home"    20
    # RPA.Browser.Selenium.Click Element    xpath=//div[text()="Receivables, Vision Operations (USA)"]
    # RPA.Browser.Selenium.Click Element    xpath=(//div[text()='Receipts']/parent::a//img[@title])[2]
    # RPA.Browser.Selenium.Click Element    xpath=//div[text()='Receipts']/following::div[text()='Receipts'][2]
    # Sleep    4s
    # RPA.Desktop.Press Keys    enter  # Download The File
    # Sleep    10s
    # RPA.Desktop.Press Keys    ctrl    j    #Go To Download Page
    # Sleep    4s
    # RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\dowloadpage.png
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    enter        # open file
    # Sleep    10s
    # Run KeyWord and Ignore Error    Select Window    Security Warning
    # Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Element    role:check box   
    # Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Push Button    Run
    # Sleep    10s
    # RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\ebsopen.png
    Select Window    Oracle Applications - EBSVIS
    print element tree    receipt_old.txt
    # Application Refresh
    # RPA.JavaAccessBridge.Type Text    Receipt Method    Manual Remittance
    # RPA.Desktop.Press Keys    enter
    # Sleep    4s
    # Application Refresh
    # RPA.Desktop.Press Keys    down
    # Sleep    4s
    # RPA.Desktop.Press Keys    enter
    # Sleep    4s
    # RPA.JavaAccessBridge.Type Text    Receipt Number    DEMO-019
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    tab
    # RPA.JavaAccessBridge.Type Text    Receipt Amount Required    2000
    # RPA.JavaAccessBridge.Type Text    NameList of Values    OC Medical Center
    # RPA.Desktop.Press Keys    enter
    # RPA.JavaAccessBridge.Click Push Button    Search
    # Application Refresh
    # RPA.JavaAccessBridge.Click Push Button    Apply
    # RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Receipt\\receiptCreated.png
    # RPA.Desktop.Press Keys    ctrl    s    #save
    # RPA.Desktop.Press Keys    alt    f4    #exit 
    # RPA.Desktop.Press Keys    enter    #exit confirm




