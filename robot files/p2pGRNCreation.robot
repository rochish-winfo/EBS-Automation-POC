*** Settings ***
Library    RPA.Browser.Selenium

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
    Input Text    xpath=//*[@id="usernameField"]    operations
    Input Password    xpath=//*[@id="passwordField"]    welcome
    Click Button    xpath=//button[text()="Log In"]
    Wait For Condition    return document.readyState == "complete"   200
    Wait Until Element Is Visible    xpath=//*[text()="iProcurement"]    10s
    Scroll Element Into View    xpath=//*[text()="iProcurement"]
    RPA.Browser.Selenium.Click Element    xpath=//*[text()="iProcurement"]
    RPA.Browser.Selenium.Click Element    xpath=//*[text()="iProcurement Home Page"]
    Wait For Condition    return document.readyState == "complete"    200
    Click Link    xpath=//*[@title="Receiving"] 
    Wait For Condition    return document.readyState == "complete" && document.title == "Oracle iProcurement: Receiving"    200
    Select From List By Label    xpath=//*[@name="SearchAttribute"]    Find by Order Number    #select from dropdown
    Input Text    xpath=//*[@name="SearchValue"]    20175014
    Click Button    xpath=//*[@title="Go"]
    Wait For Condition    return document.readyState == "complete"   200
    Checking Line Table In GRN Creation    SWC326W0002P    0.1
    RPA.Browser.Selenium.Click Button    xpath=(//button[@title="Next"])[1]
    Wait For Condition    return document.readyState == "complete"   200
    RPA.Browser.Selenium.Click Button    xpath=(//button[@title="Next"])[1]
    Wait For Condition    return document.readyState == "complete"   200
    RPA.Browser.Selenium.Click Button    xpath=//button[@id="SubmitButton"]
    Wait For Condition    return document.readyState == "complete"   200
    ${receiptNo}=    RPA.Browser.Selenium.Get Text    xpath=//b
    Log    ${receiptNo} has created


