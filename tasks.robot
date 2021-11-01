*** Settings ***
Documentation   Template robot main suite.
Library  RPA.Browser.Selenium
Library    RPA.Excel.Files
Library    OperatingSystem
Library    RPA.FileSystem
Library    RPA.Tables


*** Keyword ***
Download Path
    ${user_home}=    Get Environment Variable    UserProfile
    ${download_path}  Set Variable  ${user_home}${/}Downloads${/}
    Return From Keyword  ${download_path}

*** Keyword ***
Open RPA Challange Website 
    Open Available Browser  http://rpachallenge.com/
    Maximize Browser Window

*** Keyword ***
Download Challenge Excel File
    Click Link    //a[@href="./assets/downloadFiles/challenge.xlsx"]

*** Keyword ***
Read data from the Order file  
    [Arguments]  ${download_path}
    Open workbook    ${download_path}challenge.xlsx
    ${user_details}=    Read Worksheet As Table   header=${TRUE}
    [Return]  ${user_details}

# +
*** Tasks ***
RPA Challange Robocorp
    ${download_path}=  Download Path
    Open RPA Challange Website
    Download Challenge Excel File
    Click Button    Start
    ${user_details}  Read data from the Order file  ${download_path}
    FOR  ${user}  IN  @{user_details}
        Input Text  //*[@ng-reflect-name="labelFirstName"]  ${user}[First Name]
        Input Text  //*[@ng-reflect-name="labelLastName"]   ${user}[Last Name]
        Input Text  //*[@ng-reflect-name="labelCompanyName"]  ${user}[Company Name]
        Input Text  //*[@ng-reflect-name="labelRole"]  ${user}[Role in Company]
        Input Text  //*[@ng-reflect-name="labelAddress"]   ${user}[Address]
        Input Text  //*[@ng-reflect-name="labelEmail"]   ${user}[Email]
        Input Text  //*[@ng-reflect-name="labelPhone"]   ${user}[Phone Number]
        Click Button    Submit
    END
    Capture Element Screenshot    css:div.congratulations
    [Teardown]  Close All Browsers
        
    
    
    
    
