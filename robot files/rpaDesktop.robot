*** Settings ***
Library    RPA.Desktop.Windows


*** Tasks ***
Check all opened appllication
    &{apps}    Get Open Applications
    Log    ${apps}