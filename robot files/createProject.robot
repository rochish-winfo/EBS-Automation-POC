*** Settings ***


Library    RPA.Desktop
Library    RPA.Desktop.Windows
Library    RPA.Browser.Selenium
Library    OperatingSystem
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\Program Files\\Java\\jdk-15.0.2\\bin\\windowsaccessbridge-64.dll
Library    Process


Variables    ..\\variables\\invoiceProcessing.yaml

*** Tasks ***
Oracle Finance EBS Project Creation
    [Setup]    Set Selenium Speed    4s
    ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs} =    Create Dictionary    download.default_directory=${CURDIR}\\${EBSINFO_PRJ_CREATE.DOWNLOADPATH}    safebrowsing.enabled=${TRUE}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Call Method    ${chromeOptions}    add_argument    --disable-gpu
    Call Method    ${chromeOptions}    add_argument    --safebrowsing-disable-download-protection
    Create Webdriver    ${EBSINFO_PRJ_CREATE.BROWSER}    chrome_options=${chromeOptions}    executable_path=${DRIVER.CHROME}
    Go To    ${EBSINFO_PRJ_CREATE.URL}
    Wait Until Page Contains Element    ${EBSINFO_PRJ_CREATE.USERFIELD}
    Input Text    ${EBSINFO_PRJ_CREATE.USERFIELD}    ${EBSINFO_PRJ_CREATE.USERNAME}
    Input Password    ${EBSINFO_PRJ_CREATE.PASSWORDFIELD}    ${EBSINFO_PRJ_CREATE.PASSWORD}
    Click Button When Visible    ${EBSINFO_PRJ_CREATE.LOGINBTN}
    Wait Until Page Contains Element    ${EBSINFO_PRJ_CREATE.EXPANDBTN}
    RPA.Browser.Selenium.Click Element    ${EBSINFO_PRJ_CREATE.EXPANDBTN}
    RPA.Browser.Selenium.Click Element    ${EBSINFO_PRJ_CREATE.INVOICEBTN}
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
    RPA.Desktop.Press Keys    shift    tab
    RPA.Desktop.Press Keys    enter
    Sleep    20s
    Sleep    5s
    Select Window    Oracle Applications - EBSVIS
    Print Element Tree    projectTree1.txt
	
    RPA.JavaAccessBridge.Toggle Drop Down    role:combo box and name:Project Search for
    Sleep    5s
    RPA.Desktop.Press Keys    up
    RPA.Desktop.Press Keys    enter
    Sleep    5s
    RPA.JavaAccessBridge.Type Text    role:text and name:Project NumberList of Values    CRCentral
    # RPA.Desktop.Press Keys    tab
    RPA.JavaAccessBridge.Click Element    role:push button and name:Find alt i
    Sleep    5s
    RPA.Desktop.Press Keys    alt    c
    Sleep    5s
    RPA.JavaAccessBridge.Application Refresh
    Print Element Tree    projectTree2.txt
    ${projectele}    RPA.JavaAccessBridge.Get Elements    Project Quick Entry>Project Number Required
    RPA.JavaAccessBridge.Type Text    ${projectele}[0]    WATS_POC_01
    RPA.JavaAccessBridge.Click Element    ${projectele}[1]
    RPA.JavaAccessBridge.Type Text    ${projectele}[1]    WATS_POC_01_CREATION
    RPA.JavaAccessBridge.Click Element    ${projectele}[2]
    RPA.JavaAccessBridge.Type Text    ${projectele}[2]    Abbott, Ms. Ruth
    RPA.JavaAccessBridge.Click Element    ${projectele}[3]
    RPA.JavaAccessBridge.Type Text    ${projectele}[3]    31-DEC-2022
    RPA.JavaAccessBridge.Click Element    ${projectele}[4]
    RPA.JavaAccessBridge.Type Text    ${projectele}[04]    01-DEC-2021