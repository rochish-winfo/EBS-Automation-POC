*** Settings ***
Library    RPA.Browser.Selenium
Library    RPA.Desktop
Library    Process
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\GitHub\\EBS-Automation-POC\\Driver\\WindowsAccessBridge-64.dll
Library    RPA.Desktop.Windows


Resource    CustomKeyWords.robot

*** Tasks ***
Create Procure To Pay GRN
    [Setup]    RPA.Browser.Selenium.Set Selenium Implicit Wait    10 seconds
#     [TearDown]    Capture And Upload Screenshot    C:\\GitHub\\EBS-Automation-POC\\robot files
#     ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
#     ${prefs} =    Create Dictionary    download.prompt_for_download=${TRUE}
#     Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    # Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=Driver\\chromedriver.exe
    RPA.Browser.Selenium.Open Browser    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp    ie    executable_path=Driver\\IEDriverServer_x64_4.0.0\\IEDriverServer.exe
    # Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    RPA.Browser.Selenium.Wait For Condition    return document.readyState == "complete"    200
    RPA.Browser.Selenium.Input Text    xpath=//*[@id="usernameField"]    operations
    RPA.Browser.Selenium.Input Password    xpath=//*[@id="passwordField"]    welcome
    RPA.Browser.Selenium.Maximize Browser Window
    # RPA.Browser.Selenium.Click Button    xpath=//button[text()="Log In"]
    RPA.Browser.Selenium.Press Keys    None    RETURN
    RPA.Browser.Selenium.Wait For Condition    return document.readyState == "complete"   200
    Sleep    5s
    RPA.Browser.Selenium.Click Element    xpath=//div[text()="Inventory, Vision Operations (USA)"]
    RPA.Browser.Selenium.Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Transactions"]/parent::a//img[@title])[1]
    RPA.Browser.Selenium.Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Receiving"]/parent::a//img[@title])[1]
    RPA.Browser.Selenium.Wait For Condition    return document.readyState == "complete"
    RPA.Browser.Selenium.Click Element    xpath=(//div[text()="Receipts"])[1]
#     Sleep    4s
#     RPA.Desktop.Press Keys    enter  # Download The File
#     Sleep    10s
#     RPA.Desktop.Press Keys    ctrl    j    #Go To Download Page
#     Sleep    4s
#     RPA.Desktop.Take Screenshot    ${CURDIR}\\Screenshot\\Inovoice\\downloaded.png
#     RPA.Desktop.Press Keys    tab
#     RPA.Desktop.Press Keys    tab
#     RPA.Desktop.Press Keys    enter      
#     Sleep    20s
#     Run KeyWord and Ignore Error    Select Window    Security Warning
#     Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Element    role|check box   
#     Run Keyword And Ignore Error    RPA.JavaAccessBridge.Click Push Button    Run
#     Sleep    20s
    # Select Window    Oracle Applications - EBSVIS
    # RPA.Desktop.Press Keys    shift    tab      #go to find 
    # RPA.Desktop.Press Keys    backspace        #clear the input
    # RPA.JavaAccessBridge.Type Text    Find    M1
    # RPA.JavaAccessBridge.Click Push Button      Find
    # Application Refresh
    # RPA.JavaAccessBridge.Type Text    Purchase Order    16634
    # Application Refresh
    # ${a1}=    Get And Save Element Value    Purchase Order    C:\\GitHub\\EBS-Automation-POC\\robot files    a1
    # RPA.JavaAccessBridge.Click Push Button    Find
    # Application Refresh
    # Call Element Action    Receipt Header    close window
    # RPA.JavaAccessBridge.Click Element    role|check box
    # RPA.Desktop.Press Keys    enter
    # RPA.JavaAccessBridge.Click Element    Description
    # RPA.Desktop.Press Keys    tab    #go to requestor
    # RPA.Desktop.Press Keys    tab    #go to location
    # RPA.Desktop.Press Keys    tab    #go to subinventory
    # RPA.JavaAccessBridge.Type Text    Subinventory        FGI
    # RPA.Desktop.Press Keys    ctrl    s
    # RPA.JavaAccessBridge.Click Push Button      Header
    # Application Refresh
    # print element tree    receipt1.txt
    # ${a2}=    Get And Save Element Value    Receipt    C:\\GitHub\\EBS-Automation-POC\\robot files    a2
    # RPA.Desktop.Press Keys    alt    f4
    # Sleep   4s
    # RPA.Desktop.Press Keys    enter

    # ${a2}=    Get And Save Element Value    Receipt    C:\\GitHub\\EBS-Automation-POC\\robot files    a2    5

   
