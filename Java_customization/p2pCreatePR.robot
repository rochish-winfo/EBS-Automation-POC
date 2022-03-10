*** Settings ***
Library    RPA.Desktop
Library    customjab.py

*** Tasks ***
Create Purchasing Requisitions
    customjab.Select Java Window    Oracle Applications - EBSVIS
    customjab.Type Text    Item    AS54888
    RPA.Desktop.Press Keys    down
    customjab.Type Text    Quantity    10
    RPA.Desktop.Press Keys    tab
    customjab.Type Text    Price    100
    RPA.Desktop.Press Keys    tab
    customjab.Type Text    Need-By    15-Mar-22
    customjab.Type Text    Supplier    Advanced Network Devices
    customjab.Type Text    Site    FRESNO
    RPA.Desktop.Press Keys    ctrl    s
    ${Number}=    Get Element Text    Number    
    customjab.Click Button    Approve
    customjab.Click Button    OK
    RPA.Desktop.Press Keys    f4
    Sleep    4s
    RPA.Desktop.Press Keys    alt    f4
    Sleep    5s
    RPA.Desktop.Press Keys    enter
