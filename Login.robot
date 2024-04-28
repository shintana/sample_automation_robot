*** Settings ***
Documentation  Login Functionality
Library  SeleniumLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***
${LOGIN URL}      https://qademo.onebrick.io/login
${BROWSER}        Chrome

*** Test Cases ***
Verify Successful Login to Qademo
    Open Browser To Login Page
    Input Email    test123@yahoo.com
    Input Password    asdasd
    Submit Credentials
    Success Message Should Be Shown
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Login

Input Email
    [Arguments]    ${email}
    Input Text    your_email    ${email}

Input Password
    [Arguments]    ${password}
    Input Text    password    ${password}

Submit Credentials
    Click Button    login

Success Message Should Be Shown
    Wait until page contains    text=Success