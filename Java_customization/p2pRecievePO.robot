*** Settings ***
Library    RPA.Desktop
Library    customjavaaccessbridge.py
Library    RPA.Browser.Selenium
*** Tasks ***
Create Purchasing Requisitions
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
    # RPA.Browser.Selenium.Click Element    xpath=//div[text()="Inventory, Vision Operations (USA)"]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Transactions"]/parent::a//img[@title])[1]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Receiving"]/parent::a//img[@title])[1]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Receipts"])[1]
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
    Ebs Type Text    Find    M1
    Ebs Click Button    Find
    Ebs Type Text    Purchase Order    16886
    Ebs Click Button    Find
    Ebs Close Pop up    Receipt Header (M1)
    Ebs Click Check Box    Line
    RPA.Desktop.Press Keys    enter
    # Ebs Click Element    Description
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    tab
    # RPA.Desktop.Press Keys    tab
    Ebs Type Text    Subinventory    FGI
    RPA.Desktop.Press Keys    ctrl    s
    Ebs Click Button    Header
    ${Receipt}=    Ebs Get Element Text    Receipt
    RPA.Desktop.Press Keys    alt    f4
    Sleep    5s
    RPA.Desktop.Press Keys    enter