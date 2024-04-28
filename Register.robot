*** Settings ***
Documentation  Register Functionality
Library    SeleniumLibrary
Library    String
Library    Collections
Library    OperatingSystem

*** Variables ***
${REGISTER URL}   https://qademo.onebrick.io
${BROWSER}        Chrome
${RANDOM_STRING_LENGTH}     10

*** Test Cases ***
Verify Successful Register to Qademo
    Open Browser To Register Page
    Input First Name    David
    Input Last Name    Beckham
    ${email}=    Generate Random Email
    Input Email    ${email}
    Input Phone Number    +6285123123
    Input Address    Jakarta
    ${password}=    Generate Random Password
    Input Password    ${password}
    Input Confirm Password    ${password}
    Submit Data
    Success Message Should Be Shown
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Register Page
    Open Browser    ${REGISTER URL}    ${BROWSER}
    Title Should Be    Brick Sign Up Form

Generate Random Email
    ${random_string}=    Generate Random String    ${RANDOM_STRING_LENGTH}     [LETTERS]
    ${email}=    Set Variable    ${random_string}@gmail.com
    RETURN    ${email}

Generate Random Password
    ${random_string}=    Generate Random String    ${RANDOM_STRING_LENGTH}     [LETTERS]
    ${password}=    Set Variable    ${random_string}
    RETURN    ${password}

Input First Name
    [Arguments]    ${random_first_name}
    Input Text    firstName    ${random_first_name}

Input Last Name
    [Arguments]    ${random_last_name}
    Input Text    lastName    ${random_last_name}

Input Email
    [Arguments]    ${email}
    Input Text    email    ${email}

Input Phone Number
    [Arguments]    ${phone_number}
    Input Text    phoneNumber    ${phone_number}

Input Address
    [Arguments]    ${address}
    Input Text    address    ${address}

Input Password
    [Arguments]    ${password}
    Input Text    password    ${password}

Input Confirm Password
    [Arguments]    ${confirm_password}
    Input Text    confirm_password    ${confirm_password}

Submit Data
    Click Button    register

Success Message Should Be Shown
    Wait until page contains    text=Success