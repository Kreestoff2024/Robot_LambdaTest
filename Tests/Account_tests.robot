*** Settings ***
Resource         ../Resources/Resource_account.resource
Test Setup       Open Login Page
Test Teardown    Close Browser

*** Test Cases ***

#Tests passants

The user changes firstname
    [Template]    My Account Information (OK)
    chris@tof.com    1478963    Krystof    Bréhal    chris@tof.com    023456789

 The user changes lasttname
    [Template]    My Account Information (OK)
    chris@tof.com    1478963    Krystof    Toffe    chris@tof.com    023456789

The user changes email
    [Template]    My Account Information (OK)
    chris@tof.com    1478963    Krystof    Bréhal    chris@tof.com    023456789

The user changes telephone
    [Template]    My Account Information (OK)
    chris@tof.com    1478963    Krystof    Bréhal    chris@tof.com    123456789

#Tests non passants  Modifier informations compte - champs vides

All fields empty
    [Template]    My Account Information (KO)
    chris@tof.com    1478963    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY} 


Test all fields one by one
    [Tags]    one_by_one
    Enter Email1
    Enter Password
    Click Login
    Sleep    2s
    Click Edit your account information
    FOR    ${row}    IN    @{FIELDS_ERRORS}
         ${field}    ${locator_error}    ${message}=    Split String    ${row}    |

        Input Text     id=input-firstname    Krystof
        Input Text     id=input-lastname     Toffe
        Input Text     id=input-email        chris@tof.com
        Input Text     id=input-telephone    123456789

        Clear Element Text    ${field}
        Input Text    ${field}    ${EMPTY}

        Click Continue

        Wait Until Element Is Visible    ${locator_error}    2s

        Element Text Should Be    ${locator_error}    ${message}

        
    END

#Tests non passants - formats email non valides

Test invalid emails
    [Tags]    invalid_emails
    Enter Email1
    Enter Password
    Click Login
    Sleep    2s
    Click Edit your account information
    FOR   ${email}  IN  @{EMAILS}
        ${message}=    Set Variable    Test with     ${FIRSTNAME} / ${LASTNAME} / ${email} / ${TELEPHONE}
        Log    ${message}    INFO
        My Account Information_invalid_emails     ${FIRSTNAME}   ${LASTNAME}    ${email}    ${TELEPHONE}    
    END

#Tests non passants - longueurs mots de passe non valides


Test Change Password with Invalid Lengths
    [Tags]    invalid_passwords
    Enter Email1
    Enter Password
    Click Login
    Sleep    2s
    Click Change your password
    @{Password1}=    Create List    3        21               

    FOR    ${length}    IN    @{Password1}
        ${password}=    Generate Random String    ${length}    [NUMBERS]
        ${message}=    Set Variable    Test with length=${length} -> ${password}
        Log    ${message}    INFO
        #Input Text    id=input-confirm    1478963
        Click Continue
        
        ${message}=    Get Text    xpath=//*[@id="content"]/form/div[1]/div/div
        
        Should Be Equal    ${message}        Password must be between 4 and 20 characters!

    END

#Tests non passants - Modifier l'adresse - champs vides
    
All fields empty 2
    [Template]    My Account Information (KO2)
    chris@tof.com    1478963    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}


Test all fields one by one 2
    [Tags]    one_by_one_2
    Enter Email1
    Enter Password
    Click Login
    Sleep    2s
    Click Modifiy your address book entries
    Click Edit
    FOR    ${row}    IN    @{FIELDS_ERRORS}
         ${field}    ${locator_error}    ${message}=    Split String    ${row}    |

        Input Text                    id=input-firstname    Krystof
        Input Text                    id=input-lastname     Toffe
        Input Text                    id=input-address-1    20, rue de la plage
        Input Text                    id=input-city         Granville
        Input Text                    id=input-postcode     50200
        Select From List By Value     id=input-country      74

        IF    '${field}' == 'id=input-country'
        Select From List By Value    id=input-country    ${EMPTY}
        ELSE
        Clear Element Text    ${field}
        END

        Click Continue

        Wait Until Element Is Visible    ${locator_error}    2s

        Element Text Should Be    ${locator_error}    ${message}

        
    END