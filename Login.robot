*** Settings ***
Library             SeleniumLibrary


*** Variables ***
${url}                    https://www.saucedemo.com/
${browser}                gc
${locator_user}           id=user-name
${locator_pass}           id=password
${locator_errmsg}         xpath=//*[@id="login_button_container"]/div/form/div[3]/h3      
${locator_btn-login}      id=login-button


*** Keywords ***
Open Web Browser
    Open Browser                    ${url}       ${browser}
    Wait Until Page Contains        Swag Labs    5s
    Maximize Browser Window

Input Data Pass
    [Arguments]                       ${username}        ${pw}    
    Open Web Browser
    Wait Until Element Is Visible     ${locator_user}
    Wait Until Element Is Visible     ${locator_pass}
    Input Text                        ${locator_user}    ${username}
    Input Text                        ${locator_pass}    ${pw}
    Click Element                     ${locator_btn-login}
    Wait Until Page Contains          Products           5s
    Close Browser

Input Data Fail
    [Arguments]                        ${user}    ${pass}    ${errmsg}     
    Open Web Browser    
    Wait Until Element Is Visible      ${locator_user}
    Wait Until Element Is Visible      ${locator_pass}
    Input Text                         ${locator_user}        ${user}
    Input Text                         ${locator_pass}        ${pass}
    Click Element                      ${locator_btn-login}
    Wait Until Element Is Visible      ${locator_errmsg}
    ${txt}=    Get Text                ${locator_errmsg}
    Should Be Equal As Strings         ${txt}                 ${errmsg}
    Close Browser   

*** Test Cases ***
Verify Input Data Pass
    [Tags]             Login Pass   
    [Documentation]    Verify valid username and password
    [Template]         Input Data Pass
    standard_user      secret_sauce

Verify Input Data Fail
    [Tags]                   Login Fail
    [Documentation]          Verify invalid username and password
    [Template]               Input Data Fail
    ${EMPTY}    ${EMPTY}     Epic sadface: Username is required
    ${EMPTY}    1234564      Epic sadface: Username is required
    sabaii     ${EMPTY}      Epic sadface: Password is required
    somchai     1123344      Epic sadface: Username and password do not match any user in this service
   

   


  