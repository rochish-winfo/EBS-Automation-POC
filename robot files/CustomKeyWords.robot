*** Settings ***

Library    RPA.Browser.Selenium
Library    RPA.Desktop
Library    Process
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\EBS-Automation\\EBS Automation-POC\\Driver\\WindowsAccessBridge-64.dll
Library    RPA.Desktop.Windows
Library    RPA.FileSystem

Library    C:\\EBS-Automation\\EBS Automation-POC\\python\\fileRetrivation.py
Library    C:\\EBS-Automation\\EBS Automation-POC\\python\\ociActions.py
Library    OperatingSystem


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


Capture And Upload Screenshot
    [Arguments]    ${path}    ${index}
    
    ${getAllTheFiles}=    Get all files From path    ${path}   ${index} 
    FOR    ${file}    IN    @{getAllTheFiles}
        Log    ${path}\\${file}
        Run Keyword and Ignore Error    Put Object To Cloud    ${path}\\${file}    ${file}
    END
    
    ${state}=    RPA.FileSystem.Does Directory Exist    ${path}\\Result
    
    IF    "${state}" == "False"
        OperatingSystem.Create Directory    ${path}\\Result
    END
        
    ${filestate}=    RPA.FileSystem.Does File Exist    ${path}\\Result\\result.txt
    
    IF    "${filestate}" == "False"
        RPA.FileSystem.Create File    ${path}\\Result\\result.txt
    END

    Run Keyword If Test Passed    RPA.FileSystem.Append To File    ${path}\\Result\\result.txt    content=status=pass
    Run Keyword If Test Failed    RPA.FileSystem.Append To File    ${path}\\Result\\result.txt    content=status=fail

    

    # Run Keyword and Ignore Error    Put Object To Cloud    ${path}        

Get and Save Element Value
    [Arguments]    ${element}   ${path}   ${variable}
    [Return]    ${Text}
    ${Text}=    RPA.JavaAccessBridge.Get Element Text    role|text and name|${element}
    OperatingSystem.Create Directory    ${path}\\Result
    ${filestate}=    RPA.FileSystem.Does File Exist    ${path}\\Result\\result.txt
    
    IF    "${filestate}" == "False"
        RPA.FileSystem.Create File    ${path}\\Result\\result.txt
    END

    RPA.FileSystem.Append To FIle     ${path}\\Result\\result.txt    content=${variable}=${Text},



    