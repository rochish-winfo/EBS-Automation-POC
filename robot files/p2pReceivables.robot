*** Settings ***
Library    RPA.Browser.Selenium
Library    RPA.Desktop
Library    Process
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\Program Files\\Java\\jdk-15.0.2\\bin\\windowsaccessbridge-64.dll
Library    RPA.Desktop.Windows

Resource    CustomKeyWords.robot

*** Tasks ***
Create Procure To Pay GRN
    [Setup]    Set Selenium Speed    4 seconds
    ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=Driver\\chromedriver.exe
    Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    Wait For Condition    return document.readyState == "complete"    200
    RPA.Browser.Selenium.Input Text    xpath=//*[@id="usernameField"]    operations
    RPA.Browser.Selenium.Input Password    xpath=//*[@id="passwordField"]    welcome
    RPA.Browser.Selenium.Click Button    xpath=//button[text()="Log In"]
    Wait For Condition    return document.readyState == "complete"   200
    Sleep    5s
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Inventory, Vision Operations (USA)"]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Transactions"]/parent::a//img[@title])[1]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Receiving"]/parent::a//img[@title])[1]
    Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Receipts"])[1]
    Sleep    4s
    RPA.Desktop.Press Keys    enter  # Download The File
    Sleep    10s
    RPA.Desktop.Press Keys    ctrl    j    #Go To Download Page
    Sleep    4s
    RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Inovoice\\downloaded.png
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    enter      
    Sleep    20s
    Run KeyWord and Ignore Error    Select Window    Security Warning
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Element    role|check box   
    Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Push Button    Run
    Sleep    20s
    Select Window    Oracle Applications - EBSVIS
    Run KeyWord and Ignore Error    RPA.JavaAccessBridge.Type Text    Find    M1
    Sleep    10s
    Print Element Tree    Receivables1.txt
    RPA.JavaAccessBridge.Type Text    Purchase Order    16429
    RPA.JavaAccessBridge.Click Push Button    Find
    Sleep    10s
    Call Element Action    Receipt Header    close window
    RPA.JavaAccessBridge.Click Element    role|check box
    RPA.JavaAccessBridge.Click Push Button    OK
    RPA.JavaAccessBridge.Click Element    Description
    RPA.Desktop.Press Keys    tab    #go to requestor
    RPA.Desktop.Press Keys    tab    #go to location
    RPA.Desktop.Press Keys    tab    #go to subinventory
    RPA.JavaAccessBridge.Type Text    Subinventory        FGI
    RPA.Desktop.Press Keys    ctrl    s
    RPA.Desktop.Press Keys    alt    f4
    RPA.Desktop.Press Keys    enter
    #52 to 58 is not required now, we are not saving anything as the PO number will be gone after 1 try

   
