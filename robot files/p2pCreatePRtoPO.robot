*** Settings ***
Library    RPA.Browser.Selenium
Library    RPA.Desktop
Library    Process
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\GitHub\\EBS-Automation-POC\\Driver\\WindowsAccessBridge-64.dll
Library    RPA.Desktop.Windows

Resource    CustomKeyWords.robot

*** Tasks ***
Create Purchasing Requistion Summary
    # [Setup]    Set Selenium Implicit Wait    10   
    # ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    # ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    # Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    # Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=Driver\\chromedriver.exe
    # Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    # Wait For Condition    return document.readyState == "complete"    200
    # RPA.Browser.Selenium.Input Text    xpath=//*[@id="usernameField"]    gchockal
    # RPA.Browser.Selenium.Input Password    xpath=//*[@id="passwordField"]    welcome123
    # RPA.Browser.Selenium.Click Button    xpath=//button[text()="Log In"]
    # Wait For Condition    return document.readyState == "complete"   200
    # Sleep    5s
    # RPA.Browser.Selenium.Click Element    xpath=//div[text()="Purchasing, Vision Operations (USA)"]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=(//div[text()="AutoCreate"])[1]
    # Sleep    10s
    # RPA.Desktop.Press Keys    enter  # Download The File
    # Sleep    10s
    # RPA.Desktop.Press Keys    ctrl    j    #Go To Download Page
    # Sleep    10s
    # RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Inovoice\\downloaded.png
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    enter      
    # Sleep    10s
    Run KeyWord and Ignore Error    Select Window    Security Warning
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Element    role|check box   
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Push Button    Run
    Sleep    10s
    Select Window    Oracle Applications - EBSVIS
    Application Refresh
    RPA.JavaAccessBridge.Click Push Button    Clear
    RPA.JavaAccessBridge.Type Text    Requisition    16802
    RPA.JavaAccessBridge.Click Push Button    Find
    Sleep    5s
    Application Refresh
    RPA.JavaAccessBridge.Click Element    role|check box
    RPA.JavaAccessBridge.Click Push Button    Automatic
    Sleep    5s
    Application Refresh
    RPA.JavaAccessBridge.Type Text    Document    16802
    RPA.JavaAccessBridge.Click Push Button    Create
    Sleep    10s
    Application Refresh
    RPA.Desktop.Press Keys    ctrl    s
    RPA.Desktop.Press Keys    f4    #close all ebs winow
    RPA.Desktop.Press Keys    alt    f4    #close ebs application
    Sleep    5s
    RPA.Desktop.Press Keys    enter
    Sleep    5s
    RPA.Desktop.Press Keys    tab
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Buyer Work Center"]
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Orders"])[1]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Select From List By Label    xpath=//select[@id="ActionsPoplist"]    Update
    RPA.Browser.Selenium.Click Button    xpath=//button[@id="GoButton"]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Button    xpath=//button[@id="SubmitButton"]
    Wait For Condition    return document.readyState == "complete"

    

