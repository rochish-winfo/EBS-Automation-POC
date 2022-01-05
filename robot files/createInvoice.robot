*** Settings ***


Library    RPA.Desktop
Library    RPA.Desktop.Windows
Library    RPA.Browser.Selenium
Library    OperatingSystem
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\Program Files\\Java\\jdk-15.0.2\\bin\\windowsaccessbridge-64.dll
Library    Process


Variables    ../variables/invoiceProcessing.yaml


*** Tasks ***
Go To EBS Invoice Page
 	[Setup]    Set Selenium Speed    4s
    ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs} =    Create Dictionary    download.default_directory=${CURDIR}\\${EBSINFO.DOWNLOADPATH}    safebrowsing.enabled=${TRUE}

    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Call Method    ${chromeOptions}    add_argument    --disable-gpu
    Create Webdriver    ${EBSINFO.BROWSER}    chrome_options=${chromeOptions}    executable_path=${DRIVER.CHROME}
    Go To    ${EBSINFO.URL}
    Wait Until Page Contains Element    ${EBSINFO.USERFIELD}
    Input Text    ${EBSINFO.USERFIELD}    ${EBSINFO.USERNAME}
    Input Password    ${EBSINFO.PASSWORDFIELD}    ${EBSINFO.PASSWORD}
    Click Button When Visible    ${EBSINFO.LOGINBTN}
    Wait Until Page Contains Element    ${EBSINFO.EXPANDBTN}
    RPA.Browser.Selenium.Click Element    ${EBSINFO.EXPANDBTN}
    RPA.Browser.Selenium.Click Element    ${EBSINFO.INVOICEBTN}
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
	Call Element Action    Invoice Workbench (Winfo AP Invoice Entry)    toggle maximized
    RPA.JavaAccessBridge.Type Text    Supplier Num    100106
	RPA.JavaAccessBridge.Type Text    Invoice Date    23-DEC-2021
    RPA.JavaAccessBridge.Type Text    Invoice Num    DEMO-012
    RPA.JavaAccessBridge.Type Text    Invoice Amount    2000
    RPA.Desktop.Press Keys    Tab
    Sleep    5s
    RPA.JavaAccessBridge.Click Element    2 Lines
    # Is Wait Cursor Complete
    Sleep    10s
    Application Refresh
    Print Element Tree    projectTree1.txt

    RPA.JavaAccessBridge.Type Text    Amount Required    1000    0
    RPA.JavaAccessBridge.Type Text    Description    A4 Paper    0
    RPA.Desktop.Press Keys    alt    f    n
    RPA.JavaAccessBridge.Type Text    Amount Required    500    1
    RPA.JavaAccessBridge.Type Text    Description    A3 Paper    1
    RPA.Desktop.Press Keys    alt    f    n
    RPA.JavaAccessBridge.Type Text    Amount Required    500    2
    RPA.JavaAccessBridge.Type Text    Description    A2 Paper    2
    RPA.Desktop.Press Keys    ctrl    s
    Sleep    10s
    Call Element Action    Invoice Workbench (Winfo AP Invoice Entry)    close window




    