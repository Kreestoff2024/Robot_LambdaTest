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

@{ERRORS2}
...        xpath=//*[@id="content"]/form/fieldset/div[1]/div/div                       First Name must be between 1 and 32 characters!
...        xpath=//*[@id="content"]/form/fieldset/div[2]/div/div                       Last Name must be between 1 and 32 characters!
...        xpath=//*[@id="content"]/form/fieldset/div[4]/div/div                       Address must be between 3 and 128 characters!
...        xpath=//*[@id="content"]/form/fieldset/div[6]/div/div                       City must be between 2 and 128 characters!
#...        xpath=//*[@id="content"]/form/fieldset/div[7]/div/div                       Postcode must be between 2 and 10 characters!
...        xpath=//*[@id="content"]/form/fieldset/div[8]/div/div                       Please select a country!
...        xpath=//*[@id="content"]/form/fieldset/div[9]/div/div                       Please select a region / state!

@{FIELDS_ERRORS}  
...                  id=input-firstname|xpath=//*[@id="content"]/form/fieldset/div[1]/div/div|First Name must be between 1 and 32 characters!
...                  id=input-lastname|xpath=//*[@id="content"]/form/fieldset/div[2]/div/div|Last Name must be between 1 and 32 characters!
...                  id=input-address-1|xpath=//*[@id="content"]/form/fieldset/div[4]/div/div|Address must be between 3 and 128 characters!
...                  id=input-city|xpath=//*[@id="content"]/form/fieldset/div[6]/div/div|City must be between 2 and 128 characters!
...                  id=input-postcode|xpath=//*[@id="content"]/form/fieldset/div[7]/div/div|Postcode must be between 2 and 10 characters!
...                  id=input-country|xpath=//*[@id="content"]/form/fieldset/div[8]/div/div|Please select a country!
#...                  id=input-email|xpath=//*[@id="content"]/form/fieldset/div[3]/div/div|E-Mail Address does not appear to be valid!
#...                  id=input-telephone|xpath=//*[@id="content"]/form/fieldset/div[4]/div/div|Telephone must be between 3 and 32 characters!


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

Click Modifiy your address book entries
    Click Element    xpath=//*[@id="content"]/div[1]/div/div/div[3]/a

Click Edit
    Click Element    xpath=//*[@id="content"]/div[1]/table/tbody/tr/td[2]/a[1]

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
    FOR    ${locator}    ${message}    IN    @{ERRORS2}
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


My Account Information (KO2)
    [Arguments]    ${email}    ${password}    ${firstname}    ${lastname}    ${address1}    ${city}   ${country}    ${region}
    Input Text                       id=input-email        ${email}
    Input Password                   id=input-password    ${password}
    Click Button                     xpath=/html/body/div[1]/div[5]/div[1]/div/div/div/div[2]/div/div/form/input
    Wait Until Element Is Visible    id=column-right
    Click Element                    xpath=//*[@id="content"]/div[1]/div/div/div[3]/a
    Click Element                    xpath=//*[@id="content"]/div[1]/table/tbody/tr/td[2]/a[1]
    Input Text                       id=input-firstname    ${firstname}
    Input Text                       id=input-lastname     ${lastname}
    Input Text                       id=input-address-1    ${address1}
    Input Text                       id=input-city         ${city}
    #Input Text                       id=input-postcode     ${postcode}
    Select From List By Value        id=input-country      ${country}
    Select From List By Value        id=input-zone         ${region}
    Click Button                     xpath=//*[@id="content"]/form/div/div[2]/input
    Wait Until Element Is Visible    id=column-right
    FOR    ${locator}    ${message}    IN    @{ERRORS2}
        Run Keyword And Continue On Failure
        ...    Element Text Should Be    ${locator}    ${message}
    END