*** Settings ***
Library    RemoteSwingLibrary
# Library    C:\\GitHub\\EBS-Automation-POC\\Driver\\remoteswinglibrary-2.3.0.jar




*** Tasks ***
Doing Some Testing
    # Application Started    Oracle Applications - EBSVIS    name_contains=Oracle Applications - EBSVIS    #remote_host=winfo106.winfosolutions.com    remote_port=8035
    Start Application    myapp    javaws "C:\Users\Winfo Solutions\Downloads\frmservlet.jnlp"
    Select Dialog    Oracle Applications - EBSVIS
    # Log Java System Properties

