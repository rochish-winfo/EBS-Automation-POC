*** Settings ***

Library    RPA.Browser.Selenium

*** Tasks ***
Create A Single Vendor
    [Setup]    Set Selenium Speed    4 second
    ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs} =    Create Dictionary    download.default_directory=${CURDIR}\\Download    safebrowsing.enabled=${TRUE}    download.prompt_for_download=${FALSE}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Call Method    ${chromeOptions}    add_argument    --disable-gpu
    Call Method    ${chromeOptions}    add_argument    --safebrowsing-disable-download-protection
    Create Webdriver    Chrome    chrome_options=${chromeOptions}    executable_path=Driver\\chromedriver.exe
    Go To    http://winfo106.winfosolutions.com:8035/OA_HTML/AppsLocalLogin.jsp
    Wait Until Page Contains Element    xpath=//*[@id="usernameField"]
    Input Text    xpath=//*[@id="usernameField"]    operations
    Input Password    xpath=//*[@id="passwordField"]    welcome
    Click Button    xpath=//button[text()="Log In"]
    Wait Until Page Contains Element    xpath=//div[text()="Winfo Supplier Management"]
    Click Element    xpath=//div[text()="Winfo Supplier Management"]
    Wait Until Page Contains Element    xpath=//li[@id="LIWinfo_Supplier_Management"]//a
    Click Link    xpath=//li[@id="LIWinfo_Supplier_Management"]/a
    Wait For Condition    return document.readyState == 'complete'    20
    Click Button    xpath=//*[@id="supCreatBtn"]
    Wait For Condition    return document.title == "Create Supplier" && document.readyState == "complete"    20
    Input Text    xpath=//*[@id="organization_name"]    Geethika Trading Unit
    Input Text    xpath=//*[@id="org_name_pronunciation"]    Amanda Trading Company Ltd.
    Input Text    xpath=//*[@id="duns_number"]    ZXDk17758952
    Input Text    xpath=//*[@id="url"]    https://www.amanda.com
    Input Text    xpath=//*[@id="taxRegNum"]    GB1789183952
    Click Button    xpath=//button[@id="applyBtn"]
    
    


