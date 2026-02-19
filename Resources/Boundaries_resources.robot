*** Settings ***
Library   SeleniumLibrary
Library   String

*** Variables ***
${URL}            https://ecommerce-playground.lambdatest.io/index.php?route=account/register
${BROWSER}        Chrome


${FIRST_NAME}                Christophe
${LAST_NAME}                 Bréhal
${EMAIL}                     chris@tof.com
${TELEPHONE}                 023456789
${PASSWORD}                  1478963
${CONFIRM_PASSWORD}          1478963


*** Keywords ***
Open Home Page
    Open Browser        ${URL}        ${BROWSER}

Close Page
    Close Browser

All Fields
    [Arguments]       ${first_name}    ${last_name}    ${email}    ${telephone}    ${password}    ${confirm_password}
    Input Text        id=input-firstname    ${first_name}
    Input Text        id=input-lastname     ${last_name}
    Input Text        id=input-email        ${email}
    Input Text        id=input-telephone    ${telephone}
    Input Password    id=input-password     ${password}
    Input Password    id=input-confirm      ${confirm_password}
    Click Element     xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div/div/label
    Click Button      xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div/input
    Sleep    2s


Confirm Password Field
    [Arguments]       ${first_name}    ${last_name}    ${email}    ${telephone}    ${password}    ${confirm_password}
    Input Text        id=input-firstname    ${first_name}
    Input Text        id=input-lastname     ${last_name}
    Input Text        id=input-email        ${email}
    Input Text        id=input-telephone    ${telephone}
    Input Password    id=input-password     ${password}
    Input Password    id=input-confirm      ${confirm_password}
    Click Element     xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div/div/label
    Click Button      xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div/input
    Sleep    2s
    ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[2]/div/form/fieldset[2]/div[2]/div/div
    Log    ${message}
    Should Be Equal    ${message}    Password confirmation does not match password!



