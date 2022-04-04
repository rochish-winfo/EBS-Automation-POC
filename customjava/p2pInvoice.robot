*** Settings ***
Library    RPA.Desktop
Resource    C:/GitHub/EBS-Automation-POC/robot files/CustomKeyWords.robot
Library    RPA.Browser.Selenium
*** Tasks ***
Creating Invoice 
    # [Setup]    Set Selenium Implicit Wait    10
    # ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    # ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    # Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    # Call Method    ${chromeOptions}    add_argument    --start-maximized
    # Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=C:\\EBS-Automation\\EBS Automation-POC\\Driver\\chromedriver.exe
    # Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    # Wait For Condition    return document.readyState == "complete" && document.title == "Login"    200
    # Input Text    xpath=//*[@id="usernameField"]    gchockal
    # Input Password    xpath=//*[@id="passwordField"]    welcome123
    # Click Button When Visible    xpath=//button[text()="Log In"]
    # Wait For Condition    return document.readyState == "complete" && document.title == "Home"    200
    # RPA.Browser.Selenium.Click Element    xpath=//div[text()="Payables, Vision Operations (USA)"]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Invoices"]/parent::a//img[@title])[1]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Entry"]/parent::a//img[@title])[1]
    # Wait For Condition    return document.readyState == "complete"
    # RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Entry"]//following::div[text()="Invoices"][1])
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
    Run Keyword and Ignore Error    Call Element Action    Invoice Workbench    toggle maximized
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    Ebs Type Text    PO Number    16886
    RPA.Desktop.Press Keys    tab
    Ebs Type Text    Invoice Date    11-MAR-2022
    Ebs Type Text    Invoice Num    PO-16886
    Ebs Type Text    Invoice Amount    1000
    Ebs Click Button    Match
    Ebs Click Button    Find
    Ebs Click Element    role|check box and name|Match
    Ebs Click Button    Match
    Ebs Click Button    Calculate Tax
    ${Total}=    EBS Get Element Text    Total
    Ebs Type Text    Invoice Amount    ${Total}
    Ebs Click Button    Actions
    Ebs Click Element    role|check box and name|Validate
    Ebs Click Button    OK
    Ebs Select Menu     View    Request
    Ebs Click Button    Submit a New Request
    Ebs Type Text    Name    Create Accounting
    RPA.Desktop.Press Keys    tab
    Ebs Type Text    Ledger    Vision Operations (USA)
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    Ebs Type Text    End Date    11-MAR-22
    RPA.Desktop.Press Keys    tab
    Ebs Type Text    Mode    Draft
    Ebs Click Button    OK
    Ebs Click Button    Submit
    Ebs Click Button    Yes
    RPA.Desktop.Press Keys    backspace
    Ebs Type Text    Name    Create Accounting
    RPA.Desktop.Press Keys    tab
    Ebs Type Text    Ledger    Vision Operations (USA)
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    Ebs Type Text    End Date    11-MAR-22
    RPA.Desktop.Press Keys    tab
    Ebs Type Text    Mode    Draft
    Ebs Click Button    OK
    Ebs Click Button    Submit
    Ebs Click Button    No
    Ebs Click Button    Find
    Ebs Check Request Status    Phase
    RPA.Desktop.Press Keys    ctrl    s
