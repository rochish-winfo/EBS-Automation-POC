*** Settings ***
Library    RPA.Desktop
Resource    C:\\GitHub\\EBS-Automation-POC\\robot files\\CustomKeyWords.robot
Library    RPA.Browser.Selenium
*** Tasks ***
Getting Requisitions Summary
    # [Setup]    Set Selenium Implicit Wait    10
    # ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    # ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    # Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    # Call Method    ${chromeOptions}    add_argument    --start-maximized
    # Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=Driver\\chromedriver.exe
    # Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    # Wait For Condition    return document.readyState == "complete" && document.title == "Login"    200
    # Input Text    xpath=//*[@id="usernameField"]    gchockal
    # Input Password    xpath=//*[@id="passwordField"]    welcome123
    # Click Button When Visible    xpath=//button[text()="Log In"]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=//div[text()="Purchasing, Vision Operations (USA)"]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=(//div[text()="AutoCreate"])[1]
    # Sleep    8s
    # RPA.Desktop.Press Keys    enter
    # Sleep    15s
    # RPA.Desktop.Press Keys    ctrl    j
    # Sleep    10s
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    enter
    # Sleep    10s
    # Run KeyWord and Ignore Error    Select Ebs Window    Security Warning
    # Run Keyword And Ignore Error    Ebs Click Element    role|check box
    # Run Keyword And Ignore Error    Ebs Click Button    Run
    # Sleep    10s
    Select Ebs Window    Oracle Applications - EBSVIS
    Ebs Click Button    Clear
    Ebs Type Text    Requisition    16888
    Ebs Click Button    Find
    Ebs Click Element    role|check box
    Ebs Click Button    Automatic
    Ebs Type Text    Document    16888
    Ebs Click Button    Create
    RPA.Desktop.Press Keys    ctrl    s
    RPA.Desktop.Press Keys    alt    f4
    Sleep    5s
    RPA.Desktop.Press Keys    enter
    # Sleep    4s
    # RPA.Desktop.Press Keys    ctrl    tab
    # RPA.Browser.Selenium.Click Element    xpath=//div[text()="Buyer Work Center"]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Orders"])[1]
    # Sleep    4s
    # RPA.Browser.Selenium.Select From List By Label    xpath=//select[@id="ActionsPoplist"]   Update
    # RPA.Browser.Selenium.Click Button    xpath=//button[@id="GoButton"]
    # RPA.Browser.Selenium.Click Button    xpath=//button[@id="SubmitButton"]