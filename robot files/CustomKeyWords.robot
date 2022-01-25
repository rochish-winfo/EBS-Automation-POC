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
