*** Settings ***
Library    SeleniumLibrary
Library    String
Test Template    Register with invalid data should fail

*** Variables ***
${REGISTER URL}         https://qademo.onebrick.io
${BROWSER}              Chrome
${VALID FIRSTNAME}      David
${VALID LASTNAME}       Beckham
${VALID PHONE}          +6285123123123
${VALID EMAIL}          test@gmail.com
${VALID PASSWORD}       123456
${INVALID NAME}         !@#$%
${INVALID PHONE}        +628123
${INVALID EMAIL}        david
${INVALID PASSWORD}     1234

*** Test Cases ***          FIRSTNAME             LASTNAME             PHONE               EMAIL             PASSWORD              CONFIRMPASSWORD
# Expected 3 test cases failed since there are bugs for first name, last name, and phone number field
Invalid First Name          ${INVALID NAME}       ${VALID LASTNAME}    ${VALID PHONE}      ${VALID EMAIL}    ${VALID PASSWORD}     ${VALID PASSWORD}
Invalid Last Name           ${VALID FIRSTNAME}    ${INVALID NAME}      ${VALID PHONE}      ${VALID EMAIL}    ${VALID PASSWORD}     ${VALID PASSWORD}
Invalid Phone Number        ${VALID FIRSTNAME}    ${VALID LASTNAME}    ${INVALID PHONE}    ${VALID EMAIL}    ${VALID PASSWORD}     ${VALID PASSWORD}
Invalid Email               ${VALID FIRSTNAME}    ${VALID LASTNAME}    ${VALID PHONE}      ${INVALID EMAIL}  ${VALID PASSWORD}     ${VALID PASSWORD}
Invalid Password            ${VALID FIRSTNAME}    ${VALID LASTNAME}    ${VALID PHONE}      ${VALID EMAIL}    ${INVALID PASSWORD}   ${VALID PASSWORD}
Invalid Confirm Password    ${VALID FIRSTNAME}    ${VALID LASTNAME}    ${VALID PHONE}      ${VALID EMAIL}    ${VALID PASSWORD}     ${INVALID PASSWORD}
Empty First Name            ${EMPTY}              ${VALID LASTNAME}    ${VALID PHONE}      ${VALID EMAIL}    ${VALID PASSWORD}     ${VALID PASSWORD}
Empty Last Name             ${VALID FIRSTNAME}    ${EMPTY}             ${VALID PHONE}      ${VALID EMAIL}    ${VALID PASSWORD}     ${VALID PASSWORD}
Empty Phone Number          ${VALID FIRSTNAME}    ${VALID LASTNAME}    ${EMPTY}            ${VALID EMAIL}    ${VALID PASSWORD}     ${VALID PASSWORD}
Empty Email                 ${VALID FIRSTNAME}    ${VALID LASTNAME}    ${VALID PHONE}      ${EMPTY}          ${VALID PASSWORD}     ${VALID PASSWORD}
Empty Password              ${VALID FIRSTNAME}    ${VALID LASTNAME}    ${VALID PHONE}      ${VALID EMAIL}    ${EMPTY}              ${VALID PASSWORD}
Empty Confirm Password      ${VALID FIRSTNAME}    ${VALID LASTNAME}    ${VALID PHONE}      ${VALID EMAIL}    ${VALID PASSWORD}     ${EMPTY}

*** Keywords ***
Register with invalid data should fail
    [Arguments]    ${firstname}    ${lastname}  ${phone}     ${email}    ${password}      ${confirm_password}
    Open Browser    ${REGISTER URL}    ${BROWSER}
    Input Text    firstName    ${firstname}
    Input Text    lastName    ${lastname}
    Run Keyword If    "${email}" == "test@gmail.com"     Generate and Input Email
    ...    ELSE    Input Text    email    ${email}
    Input Text    phoneNumber    ${phone}
    Input Text    password    ${password}
    Input Text    confirm_password    ${confirm_password}
    Click Button    register
    Page Should Contain Element    css=label.error

Generate and Input Email
    ${random_string}=    Generate Random String    10    [LETTERS]
    Input Text    email    ${random_string}@gmail.com
