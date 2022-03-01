*** Settings ***

Library    RPA.Desktop
Library    RPA.Desktop.Windows
Library    RPA.Browser.Selenium
Library    OperatingSystem
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\Program Files\\Java\\jdk-15.0.2\\bin\\windowsaccessbridge-64.dll
Library    Process


Variables    ..\\variables\\invoiceProcessing.yaml


*** Tasks ***
Oracle Finance EBS Cash Receipt Creation
    [Setup]    Set Selenium Speed    4s
    ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs} =    Create Dictionary    download.default_directory=${CURDIR}\\${EBSINFO_CASH_REC_CREATE.DOWNLOADPATH}    #safebrowsing.enabled=${TRUE}

    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Call Method    ${chromeOptions}    add_argument    --disable-gpu
    Create Webdriver    ${EBSINFO_CASH_REC_CREATE.BROWSER}    chrome_options=${chromeOptions}    executable_path=${DRIVER.CHROME}
    Go To    ${EBSINFO_CASH_REC_CREATE.URL}
    Take Screenshot    ${CURDIR}\\Screenshots\\ebswebpageLogin.png
    Wait Until Page Contains Element    ${EBSINFO_CASH_REC_CREATE.USERFIELD}
    Input Text    ${EBSINFO_CASH_REC_CREATE.USERFIELD}    ${EBSINFO_CASH_REC_CREATE.USERNAME}
    Input Password    ${EBSINFO_CASH_REC_CREATE.PASSWORDFIELD}    ${EBSINFO_CASH_REC_CREATE.PASSWORD}
    Click Button When Visible    ${EBSINFO_CASH_REC_CREATE.LOGINBTN}
    Wait Until Page Contains Element    ${EBSINFO_CASH_REC_CREATE.EXPANDBTN1}    10s
    RPA.Browser.Selenium.Click Element    ${EBSINFO_CASH_REC_CREATE.EXPANDBTN1}
    Wait Until Page Contains Element    ${EBSINFO_CASH_REC_CREATE.EXPANDBTN2}    10s
    RPA.Browser.Selenium.Click Element    ${EBSINFO_CASH_REC_CREATE.EXPANDBTN2}
    Wait Until Page Contains Element    ${EBSINFO_CASH_REC_CREATE.CLICK_RECEIPT}    10s
    RPA.Browser.Selenium.Click Element    ${EBSINFO_CASH_REC_CREATE.CLICK_RECEIPT}
    Sleep    15s
    RPA.Desktop.Press Keys    ctrl    j
    Sleep    2s
    RPA.Desktop.Press Keys    tab    
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    enter
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    enter
    Sleep    20s    
    Take Screenshot    ${CURDIR}\\Screenshots\\ebswebpageformDownload.png
    RPA.Desktop.Press Keys    shift    tab
    RPA.Desktop.Press Keys    enter
    Sleep    20s
    Take Screenshot    ${CURDIR}\\Screenshots\\ebsform.png
    Select Window    Oracle Applications - EBSVIS
    Sleep    20s
    Application Refresh
    Print Element Tree    projectTree1.txt
    Call Element Action    Receipts (Vision Operations    toggle maximized
    RPA.JavaAccessBridge.Type Text    Receipt Method    Manual Remittance
    RPA.Desktop.Press Keys    enter
    Sleep    2s
    RPA.Desktop.Press Keys    down
    RPA.Desktop.Press Keys    enter
    Sleep    5s
    RPA.JavaAccessBridge.Type Text    Receipt Number    DEMO-011

    # RPA.JavaAccessBridge.Type Text    Receipt Amount Required    2000    19    1
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Type Text    2000

    RPA.JavaAccessBridge.Type Text    NameList of Values    OC Medical Center
    RPA.Desktop.Press Keys    enter
    RPA.Desktop.Press Keys    alt    s
    Sleep    10s
    # RPA.JavaAccessBridge.Type Text    Transaction Number    1200
    # RPA.JavaAccessBridge.Type Text    Transaction Number High    1200
    Print Element Tree    projectTree2.txt
    RPA.Desktop.Press Keys    alt    y
    # RPA.JavaAccessBridge.Click Push Button    Apply alt y
    Sleep    4s
    RPA.Desktop.Press Keys    alt    s
    Sleep    10s
    Run Keyword And Ignore Error    Call Element Action    Applications -    close window
    Sleep    4s
    Run Keyword And Ignore Error    Call Element Action    Applications -    close window
    Run Keyword And Ignore Error    Call Element Action    Receipts (Vision Financial Services (USA)    close window

