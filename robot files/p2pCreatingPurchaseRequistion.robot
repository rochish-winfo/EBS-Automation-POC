*** Settings ***
Library    RPA.Browser.Selenium
Library    RPA.Desktop
Library    Process
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=Driver\\WindowsAccessBridge-64.dll
Library    RPA.Desktop.Windows

Resource    CustomKeyWords.robot

*** Tasks ***
Create Purchasing Requistion
    # [Setup]    Set Selenium Implicit Wait    10
    # # [TearDown]    Captu15-Mar-22re And Upload Screenshot    C:\\GitHub\\EBS-Automation-POC\\robot files
    # ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    # ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    # Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    # Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=Driver\\chromedriver.exe
    # Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    # Wait For Condition    return document.readyState == "complete"    200
    # RPA.Browser.Selenium.Input Text    xpath=//*[@id="usernameField"]    operations
    # RPA.Browser.Selenium.Input Password    xpath=//*[@id="passwordField"]    welcome
    # RPA.Browser.Selenium.Click Button    xpath=//button[text()="Log In"]
    # Wait For Condition    return document.readyState == "complete"   200
    # Sleep    5s
    # RPA.Browser.Selenium.Click Element    xpath=//div[text()="Purchasing, Vision Operations (USA)"]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Requisitions"]/parent::a//img[@title])[1]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=//div[text()='Requisitions']/following::div[text()='Requisitions'][2]
    # Sleep    4s
    # RPA.Desktop.Press Keys    enter  # Download The File
    # Sleep    15s
    # RPA.Desktop.Press Keys    ctrl    j    #Go To Download Page
    # Sleep    8s
    # RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Inovoice\\downloaded.png
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    enter      
    # Sleep    20s
    # Run KeyWord and Ignore Error    Select Window    Security Warning
    # Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Element    role|check box   
    # Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Push Button    Run
    # Sleep    20s
    Select Window    Oracle Applications - EBSVIS
    Application Refresh
    RPA.JavaAccessBridge.Type Text    name|Item    AS54888
    RPA.Desktop.Press Keys    down    #load the num
    RPA.JavaAccessBridge.Type Text    name|Quantity    1
    RPA.Desktop.Press Keys    tab    #go to Price
    RPA.JavaAccessBridge.Type Text    name|Price    10
    RPA.Desktop.Press Keys    tab    #go to Need By
    RPA.JavaAccessBridge.Type Text    name|Need-By    15-MAR-2022
    RPA.JavaAccessBridge.Type Text    name|Supplier     Advanced Network Devices
    RPA.JavaAccessBridge.Type Text    name|Site     FRESNO
    RPA.Desktop.Press Keys    ctrl    s
    Application Refresh
    ${num}=    Get And Save Element Value    Number    C:\\GitHub\\EBS-Automation-POC\\robot files    Number
    RPA.JavaAccessBridge.Click Push Button    Approve
    Application Refresh
    RPA.JavaAccessBridge.Click Push Button    OK
    Application Refresh
    RPA.Desktop.Press Keys    f4    #close all ebs winow
    RPA.Desktop.Press Keys    alt    f4    #close ebs application
    Sleep    5s
    RPA.Desktop.Press Keys    enter
    
