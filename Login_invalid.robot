*** Settings ***
Library    SeleniumLibrary
Test Template    Login with invalid credentials should fail

*** Variables ***
${LOGIN URL}            https://qademo.onebrick.io/login
${BROWSER}              Chrome
${VALID EMAIL}          david.beckham@gmail.com
${VALID PASSWORD}       123456
${INVALID DATA}         invalid

*** Test Cases ***                EMAIL                 PASSWORD
Invalid Email                     ${INVALID DATA}       ${VALID PASSWORD}
Invalid Password                  ${VALID EMAIL}        ${INVALID DATA}
Invalid Email and Password        ${INVALID DATA}       ${INVALID DATA}
Empty Email                       ${EMPTY}              ${VALID PASSWORD}
Empty Password                    ${VALID EMAIL}        ${EMPTY}
Empty Email and Password          ${EMPTY}              ${EMPTY}

*** Keywords ***
Login with invalid credentials should fail
    [Arguments]    ${email}    ${password}
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Input Text    your_email    ${email}
    Input text    password      ${password}
    Click button    login
    ${value}=    Get Element Attribute    id=type    value
    Run Keyword If    "${value}" == "error"     Should Be Equal As Strings    ${value}    error
    Close Browser