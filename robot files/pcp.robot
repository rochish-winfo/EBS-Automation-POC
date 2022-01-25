*** Settings ***

Library    RPA.Browser.Selenium
Library    RPA.Desktop
Library    Process
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\Program Files\\Java\\jdk-15.0.2\\bin\\windowsaccessbridge-64.dll
Library    RPA.FTP
Resource    CustomKeyWords.robot


*** Tasks ***
Create Period Close Process
    [Setup]    Set Selenium Speed    4 second
    ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Call Method    ${chromeOptions}    add_argument    --disable-gpu
    Call Method    ${chromeOptions}    add_argument    --safebrowsing-disable-download-protection
    Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=C:\\GitHub\\EBS-Automation-POC\\Driver\\chromedriver.exe
    Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    Wait For Condition    return document.readyState == "complete" && document.title == "Login"    200
    Input Text    xpath=//*[@id="usernameField"]    operations
    Input Password    xpath=//*[@id="passwordField"]    welcome
    Click Button    xpath=//button[text()="Log In"]
    Wait For Condition    return document.readyState == "complete" && document.title == "Home"    200
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="RPA PERIOD CLOSURE"]
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="RPA PERIOD CLOSURE"]//following::div[text()="Requests"]
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="RPA PERIOD CLOSURE"]//following::div[text()="Run"]
    Sleep    4s
    RPA.Desktop.Press Keys    enter  # Download The File
    Sleep    10s
    RPA.Desktop.Press Keys    ctrl    j     #Go To Download Page
    Sleep    4s
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    enter        # open file
    # Sleep    20s
    Run KeyWord and Ignore Error    Select Window    Security Warning
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Element    role:check box   
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Push Button    Run
    Sleep    20s
    Select Window    Oracle Applications - EBSVIS
    Sleep    20s
    Click Push Button    Cancel
    Sleep    4s
    Application Refresh
    RPA.Desktop.Press Keys    ctrl    l    #search (it will be same for every action)
    RPA.JavaAccessBridge.Type Text    Find    Open
    Sleep    5s
    Application Refresh
    Click Push Button    OK
    # from step 42 to 46 is going open lager form
    Sleep    4s
    Application Refresh
    RPA.JavaAccessBridge.Type Text    name:Period    FEB-20
    Click Push Button    Find

    Print Element Tree    check2.txt
    Call Element Action    Find Periods    close window
    Close Open And Close Period Window
    RPA.Desktop.Press Keys    ctrl    l    #search (it will be same for every action)
    RPA.JavaAccessBridge.Type Text    Find    AP



    





    



    