*** Settings ***
Library    RPA.Desktop
Library    RPA.Desktop.Windows
Library    Screenshot
Library    OperatingSystem
Resource    C:\\EBS-Automation\\EBS Automation-POC\\robot files\\CustomKeywords.robot
Variables    C:\\EBS-Automation\\EBS Automation-POC\\robot files\\excelinfo.yaml
*** Tasks ***
Create Journal Entry
    [Setup]    Set Automation Speed    slow
    [TearDown]    Capture And Upload Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\excel\\WATS\\DHADFDI6    1
    OperatingSystem.Create Directory    C:\\EBS-Automation\\WATS_Files\\screenshot\\excel\\WATS\\DHADFDI6
    Open Excel File With Sheet    CreateMassFinancialTransaction    Manage Financial Transactions
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\excel\\WATS\\DHADFDI6\\1_10_CreateMassFinancialTransactions_OTC.AR.2048_DHADFDI6_10_Passed.jpg
    Login To Excel    FIN_IMPL    oVY3p%3*
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\excel\\WATS\\DHADFDI6\\1_20_CreateMassFinancialTransactions_OTC.AR.2048_DHADFDI6_20_Passed.jpg
    Type Into Cell    Asset Number    100001
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\excel\\WATS\\DHADFDI6\\1_30_CreateMassFinancialTransactions_OTC.AR.2048_DHADFDI6_30_Passed.jpg
    Type Into Cell    Posting Status    Post
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\excel\\WATS\\DHADFDI6\\1_40_CreateMassFinancialTransactions_OTC.AR.2048_DHADFDI6_40_Passed.jpg
    Type Into Cell    New Financial Details>Cost    4,000,000.00
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\excel\\WATS\\DHADFDI6\\1_50_CreateMassFinancialTransactions_OTC.AR.2048_DHADFDI6_50_Passed.jpg
    Select Menu Item Of Excel    Post
    Screenshot.Take Screenshot    C:\\EBS-Automation\\WATS_Files\\screenshot\\excel\\WATS\\DHADFDI6\\1_60_CreateMassFinancialTransactions_OTC.AR.2048_DHADFDI6_60_Passed.jpg
    Close Excel
