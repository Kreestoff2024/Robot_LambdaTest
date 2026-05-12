*** Settings ***
Library        SeleniumLibrary
Library        String
Library        browser_options.py
Library        squash_tf.TFParamService

*** Variables ***
${URL}                       https://ecommerce-playground.lambdatest.io/index.php?route=account/register
${BROWSER}                   Chrome        

@{DATA1}                     Christophe    Bréhal    @tof.com    023456789    1478963    1478963
@{DATA2}                     Christophe    Bréhal    chris@      023456789    1478963    1478963
@{DATA3}                     Christophe    Bréhal    chris@.com  023456789    1478963    1478963
@{DATA4}                     Christophe    Bréhal    chris.com   023456789    1478963    1478963

${FIRST_NAME}                Christophe
${LAST_NAME}                 Bréhal
@{EMAILS}                    chris@        @tof.com    chris.com    chris@.com    chris@tof
${TELEPHONE}                 023456789
${PASSWORD}                  1478963
${CONFIRM_PASSWORD}          1478963

@{ERRORS}
...    xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/fieldset[2]/div[1]/div/div       Password must be between 4 and 20 characters!
...    xpath=//*[@id="account"]/div[5]/div/div                                             Telephone must be between 3 and 32 characters!
...    xpath=//*[@id="account"]/div[4]/div/div                                             E-Mail Address does not appear to be valid!
...    xpath=//*[@id="account"]/div[3]/div/div                                             Last Name must be between 1 and 32 characters!
...    xpath=//*[@id="account"]/div[2]/div/div                                             First Name must be between 1 and 32 characters!


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
    Input Text    id=input-email    khris@tof.com

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
    Input Text        id=input-firstname    ${first_name}
    Input Text        id=input-lastname     ${last_name}
    Input Text        id=input-email        ${email}
    Input Text        id=input-telephone    ${telephone}
    Input Password    id=input-password     ${password}
    Input Password    id=input-confirm      ${confirm_password}
    Click Element     xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div/div/label
    Click Button      xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div/input

    
    Execute JavaScript    document.getElementById("input-email").form.noValidate = true
    Execute JavaScript    document.getElementById("input-email").form.submit()

    ${inline_message}=    Set Variable    NONE
    ${global_message}=    Set Variable    NONE
    ${inline_elem}=    Execute JavaScript    return document.querySelector("#input-email + div.text-danger");
    IF    ${inline_elem}
        ${inline_message}=    Execute JavaScript    return document.querySelector("#input-email + div.text-danger").innerText
        Should Not Be Empty    ${inline_message}
        Log    Message inline: ${inline_message}
    ELSE
        Log    Aucun message inline pour cet email
    END

    ${global_elem}=    Execute JavaScript    return document.querySelector("#account div.alert");
    IF    ${global_elem}
        ${global_message}=    Execute JavaScript    return document.querySelector("#account div.alert").innerText
        Should Not Be Empty    ${global_message}
        Log    Message global: ${global_message}
    ELSE
        Log    Aucun message global pour cet email
    END

Register User2
   [Arguments]       ${first_name}    ${last_name}    ${email}    ${telephone}    ${password}    ${confirm_password}
    Input Text        id=input-firstname    ${first_name}
    Input Text        id=input-lastname     ${last_name}
    Input Text        id=input-email        ${email}
    Input Text        id=input-telephone    ${telephone}
    Input Password    id=input-password     ${password}
    Input Password    id=input-confirm      ${confirm_password}
    Click Element     xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div/div/label
    Click Button      xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div/input
    ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/fieldset[2]/div[1]/div/div
    Log    ${message}   
    Should Be Equal    ${message}         Password must be between 4 and 20 characters!