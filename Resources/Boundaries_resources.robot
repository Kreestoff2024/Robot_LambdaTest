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

Enter FIRST_NAME
    Input Text    id=input-firstname    Christophe

Enter LAST_NAME
    Input Text    id=input-lastname    Bréhal

Enter EMAIL
    Input Text    id=input-email    chris@tof.com

Enter TELEPHONE
    Input Text    id=input-telephone    023456789

Enter PASSWORD
    Input Password    id=input-password    1478963

Enter CONFIRM_PASSWORD
    Input Password    id=input-confirm    1478963

Click on Privacy Policy
    Click Element    xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div/div/label

Click on Continue
    Click Button    xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div/input

Registration is confirmed
    Get WebElement    xpath=/html/body/div[1]/div[5]/div[1]/div/div/h1


Firstname Field
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
    ${message}=    Execute JavaScript    return document.querySelector("input[name='firstname']").validationMessage;
    Log  ${message}    level=INFO
    RETURN           ${message}

Lastname Field
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
    ${message}=    Execute JavaScript    return document.querySelector("input[name='lastname']").validationMessage;
    Log  ${message}    level=INFO
    RETURN           ${message}






