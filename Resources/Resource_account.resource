*** Settings ***
Library    SeleniumLibrary
Library    String
Library    browser_options.py


*** Variables ***
${URL}                    https://ecommerce-playground.lambdatest.io/index.php?route=account/login
${BROWSER}                Chrome

@{ERRORS}
...        xpath=//*[@id="content"]/form/fieldset/div[1]/div/div                       First Name must be between 1 and 32 characters!
...        xpath=//*[@id="content"]/form/fieldset/div[2]/div/div                       Last Name must be between 1 and 32 characters!
...        xpath=//*[@id="content"]/form/fieldset/div[3]/div/div                       E-Mail Address does not appear to be valid!
...        xpath=//*[@id="content"]/form/fieldset/div[4]/div/div                       Telephone must be between 3 and 32 characters!


@{FIELDS_ERRORS}  
...                  id=input-firstname|xpath=//*[@id="content"]/form/fieldset/div[1]/div/div|First Name must be between 1 and 32 characters!
...                  id=input-lastname|xpath=//*[@id="content"]/form/fieldset/div[2]/div/div|Last Name must be between 1 and 32 characters!
...                  id=input-email|xpath=//*[@id="content"]/form/fieldset/div[3]/div/div|E-Mail Address does not appear to be valid!
...                  id=input-telephone|xpath=//*[@id="content"]/form/fieldset/div[4]/div/div|Telephone must be between 3 and 32 characters!


${FIRSTNAME}    Krystof
${LASTNAME}     Toffe
@{EMAILS}       chris@    @tof.com    chris.com    chris@.com    chris@tof
${TELEPHONE}    123456789

${Password1}    id=input-password



*** Keywords ***
Open Login Page
    ${options}=         Get Chrome Options
    Open Browser        ${URL}        ${BROWSER}    options=${options}

Close Page
    Close Browser

Enter Email1
    Input Text         id=input-email      chris@tof.com

Enter Password
    Input Password    id=input-password    1478963

Click Login
    Click Button     xpath=/html/body/div[1]/div[5]/div[1]/div/div/div/div[2]/div/div/form/input

Click Edit your account information
    Click Element     xpath=/html/body/div[1]/div[5]/div[1]/div/div/div[1]/div/div/div[1]/a

Click Change your password
    Click Element    xpath=//*[@id="content"]/div[1]/div/div/div[2]/a

Enter Firstname
    Input Text    id=input-firstname    Krystof

Enter Firstname_empty
    Input Text    id=input-firstname    ""

Enter Lastname
    Input Text    id=input-lastname    Toffe

Enter E-mail2
    Input Text    id=input-email       chris@tof.com

Enter Telephone
    Input Text    id=input-telephone         123456789

Click Continue
    Click Button    xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div[2]/input

My Account Information (OK)
    [Arguments]    ${email1}    ${password}    ${firstname}    ${lastname}    ${email}    ${telephone}
    Input Text                       id=input-email        ${email1}
    Input Password                   id=input-password    ${password}
    Click Button                     xpath=/html/body/div[1]/div[5]/div[1]/div/div/div/div[2]/div/div/form/input
    Wait Until Element Is Visible    id=column-right
    Click Element                    xpath=//*[@id="content"]/div[1]/div/div/div[1]/a
    Input Text                       id=input-firstname    ${firstname}
    Input Text                       id=input-lastname     ${lastname}
    Input Text                       id=input-email        ${email}
    Input Text                       id=input-telephone    ${telephone}
    Click Button                     xpath=//*[@id="content"]/form/div/div[2]/input
    Wait Until Element Is Visible    id=column-right
    ${message}    Get Text     xpath=//*[@id="account-account"]/div[1]
    Should Be Equal    ${message}    Success: Your account has been successfully updated.

My Account Information (KO)
    [Arguments]    ${email1}    ${password}    ${firstname}    ${lastname}    ${email}    ${telephone}
    Input Text                       id=input-email        ${email1}
    Input Password                   id=input-password    ${password}
    Click Button                     xpath=/html/body/div[1]/div[5]/div[1]/div/div/div/div[2]/div/div/form/input
    Wait Until Element Is Visible    id=column-right
    Click Element                    xpath=//*[@id="content"]/div[1]/div/div/div[1]/a
    Input Text                       id=input-firstname    ${firstname}
    Input Text                       id=input-lastname     ${lastname}
    Input Text                       id=input-email        ${email}
    Input Text                       id=input-telephone    ${telephone}
    Click Button                     xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div[2]/input
    Wait Until Element Is Visible    id=column-right
    FOR    ${locator}    ${message}    IN    @{ERRORS}
        Run Keyword And Continue On Failure
        ...    Element Text Should Be    ${locator}    ${message}
    END

My Account Information_invalid_emails
    [Arguments]       ${firstname}    ${lastname}    ${email}    ${telephone}
    Input Text                       id=input-firstname    ${firstname}
    Input Text                       id=input-lastname     ${lastname}
    Input Text                       id=input-email        ${email}
    Input Text                       id=input-telephone    ${telephone}
    Click Button                     xpath=//*[@id="content"]/form/div/div[2]/input
    Wait Until Element Is Visible    id=column-right
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