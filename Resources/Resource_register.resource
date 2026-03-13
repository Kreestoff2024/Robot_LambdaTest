*** Settings ***
Library        SeleniumLibrary
Library        String
Library        browser_options
*** Variables ***
${URL}                       https://ecommerce-playground.lambdatest.io/index.php?route=account/register
${BROWSER}                   Chrome        

@{DATA1}                     Christophe    Bréhal    @tof.com    023456789    1478963    1478963
@{DATA2}                     Christophe    Bréhal    chris@      023456789    1478963    1478963
@{DATA3}                     Christophe    Bréhal    chris@.com  023456789    1478963    1478963
@{DATA4}                     Christophe    Bréhal    chris@com   023456789    1478963    1478963

${FIRST_NAME}                Christophe
${LAST_NAME}                 Bréhal
@{EMAILS}                    chris@        @tof.com    chris.com    chris@com    chris@tof
${TELEPHONE}                 023456789
${PASSWORD}                  1478963
${CONFIRM_PASSWORD}          1478963



*** Keywords ***

Open Home Page
    ${options}=     Get Chrome Options
    Open Browser    ${URL}    ${BROWSER}    options=${options}

Close Browsers
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

Uncorrect password confirmation
    Input Password    id=input-confirm    1477414

Register user
    [Arguments]       ${first_name}    ${last_name}    ${email}    ${telephone}    ${password}    ${confirm_password}
    #Open Browser      https://ecommerce-playground.lambdatest.io/index.php?route=account/register
    Input Text        id=input-firstname    ${first_name}
    Input Text        id=input-lastname     ${last_name}
    Input Text        id=input-email        ${email}
    Input Text        id=input-telephone    ${telephone}
    Input Password    id=input-password     ${password}
    Input Password    id=input-confirm      ${confirm_password}
    Click Element     xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div/div/label
    Click Button      xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div/input
    Sleep    2s
    ${message}=    Execute JavaScript    return document.querySelector("input[name='email']").validationMessage;
    Log  ${message}    level=INFO
    Should Not Be Empty       ${message}
    #Close Browser