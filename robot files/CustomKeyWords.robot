*** Settings ***

Library    RPA.Browser.Selenium
Library    RPA.Desktop
Library    Process
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=Driver\\WindowsAccessBridge-64.dll
Library    RPA.Desktop.Windows


*** Keywords ***
Close Open And Close Period Window
    Mouse Click Coords    x=847    y=109

Checking Line Table In GRN Creation    
    [Arguments]    ${desc}    ${amount}
    ${rows}=    RPA.Browser.Selenium.Get Element Count    xpath=//table[@id="ResultsTableRN:Content"]/tbody/tr
    FOR    ${rowNum}    IN RANGE    1    ${rows+1}    
        ${rowText}=    RPA.Browser.Selenium.Get Text    xpath=//table[@id="ResultsTableRN:Content"]/tbody/tr[${rowNum}]/td[4]
        Log    ${rowText}
        IF    "${rowText}" == "${desc}"
            RPA.Browser.Selenium.Click Element    xpath=//table[@id="ResultsTableRN:Content"]/tbody/tr[${rowNum}]/td[1]/span
            RPA.Browser.Selenium.Input Text    xpath=//table[@id="ResultsTableRN:Content"]/tbody/tr[${rowNum}]/td[6]/input    ${amount}
        END
    END



Insert Line No For PO Invoice
    [Arguments]    ${lineNo}
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Press Keys    tab
    RPA.Desktop.Type Text    ${lineNo}

Switching Responsiblity in EBS
    [Arguments]    ${toFind}
    RPA.JavaAccessBridge.Click Element    role|menu item and name|Switch Responsibility
    RPA.JavaAccessBridge.Application Refresh
    RPA.Desktop.Press Keys    shift    tab
    RPA.Desktop.Press Keys    backspace
    RPA.JavaAccessBridge.Type Text    name|Find    ${toFind}
    RPA.Desktop.Press Keys    alt    f

Navigating Responsibility in EBS
    [Arguments]    ${locator}
    Set Automation Speed    slow
    Sleep    10s
    Application Refresh
    ${locators}=    Set Variable    ${locator.split(">>")[-1]}
    RPA.Desktop.Press Keys    ctrl    l
    RPA.Desktop.Press Keys    shift    tab
    RPA.Desktop.Press Keys    backspace
    RPA.JavaAccessBridge.Type Text    name|Find    ${locators}
    Sleep    5s
    RPA.Desktop.Press Keys    alt    f
