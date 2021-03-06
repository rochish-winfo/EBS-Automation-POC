*** Settings ***

Library    RPA.Browser.Selenium
Library    RPA.Desktop
Library    Process
Library    RPA.JavaAccessBridge    ignore_callbacks=True    access_bridge_path=C:\\GitHub\\EBS-Automation-POC\\Driver\\WindowsAccessBridge-64.dll
Library    RPA.Desktop.Windows
Library    RPA.FileSystem

Library    C:\\GitHub\\EBS-Automation-POC\\python\\fileRetrivation.py
Library    C:\\GitHub\\EBS-Automation-POC\\python\\ociActions.py
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

    Run Keyword and Ignore Error    Move Dir    ${path}    ${index}

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
    Application Refresh
    ${Text}=    RPA.JavaAccessBridge.Get Element Text    role|text and name|${element}
    OperatingSystem.Create Directory    ${path}\\Result
    ${filestate}=    RPA.FileSystem.Does File Exist    ${path}\\Result\\result.txt
    
    IF    "${filestate}" == "False"
        RPA.FileSystem.Create File    ${path}\\Result\\result.txt
    END

    RPA.FileSystem.Append To FIle     ${path}\\Result\\result.txt    content=${variable}=${Text},

Get Element Value
    [Arguments]    ${element}   ${path}   ${variable}
    [Return]    ${Text}
    ${Text}=    RPA.Browser.Selenium.Get Text    ${element}
    OperatingSystem.Create Directory    ${path}\\Result
    ${filestate}=    RPA.FileSystem.Does File Exist    ${path}\\Result\\result.txt
    
    IF    "${filestate}" == "False"
        RPA.FileSystem.Create File    ${path}\\Result\\result.txt
    END

    RPA.FileSystem.Append To FIle     ${path}\\Result\\result.txt    content=${variable}=${Text.split()[-1]},

Wait For Element Status For Change
    [Arguments]    ${element}    #${path}
    ${Text}=   RPA.JavaAccessBridge.Get Element Text    role|text and name|${element}
    FOR    ${temp}    IN RANGE    1    100
        Sleep    3s
        ${text}=    RPA.JavaAccessBridge.Get Element Text    role|text and name|${element}
        Exit For Loop IF    "${text}" != "${Text}"
        Exit For Loop IF    "${text}" == "Completed"
        Exit For Loop IF    "${text}" != "Running"
        RPA.Desktop.Press Keys    alt    R
        Application Refresh
    END

    # Log    ${element} status changed to ${text} from ${Text}
    # Get and Save Element Value    ${element}    ${path}    ${element}


Ebs Type Text
    [Arguments]    ${locator}    ${value}    ${index}=0
    ${typed}=    Run Keyword And Return Status    RPA.JavaAccessBridge.Type Text    ${locator}    ${value}    ${index}    clear=True
    IF    ${typed} == ${FALSE}
        Application Refresh
        RPA.JavaAccessBridge.Type Text    ${locator}    ${value}    ${index}    clear=True
    END

Ebs Click Button
    [Arguments]    ${locator}
    ${clicked}=    Run Keyword And Return Status    RPA.JavaAccessBridge.Click Push Button    ${locator}
    IF    ${clicked} == ${FALSE}
        Application Refresh
        RPA.JavaAccessBridge.Click Push Button    ${locator}
    END

Ebs Click Element
    [Arguments]    ${locator}    ${index}=0
    ${clicked}=    Run Keyword And Return Status    RPA.JavaAccessBridge.Click Element    ${locator}    ${index}
    IF    ${clicked} == ${FALSE}
        Application Refresh
        RPA.JavaAccessBridge.Click Element    ${locator}    ${index}
    END


Select Ebs Window 
    [Arguments]    ${name}
    ${clicked}=    Run Keyword And Return Status    Select Window    ${name}
    IF    ${clicked} == ${FALSE}
        Sleep    5s
        Select Window    ${name}
    END

Ebs Get Element Text
    [Arguments]    ${element}
    [Return]    ${Text}
    Application Refresh
    ${Text}=    RPA.JavaAccessBridge.Get Element Text    role|text and name|${element}

Ebs Close Pop up 
    [Arguments]    ${name}
    RPA.Desktop.Press Keys    CTRL    F4
    Sleep    4s

Ebs Select Menu 
    [Arguments]    ${menu}    ${menuitem}
    ${clicked}=    Run KeyWord And Return Status    RPA.JavaAccessBridge.Select Menu    ${menu}    ${menuitem}
    IF   ${clicked} == ${FALSE}
        RPA.JavaAccessBridge.Select Menu    ${menu}    ${menuitem}
    END

Ebs Check Request Status
    [Arguments]    ${element}
    Wait For Element Status For Change    ${element}