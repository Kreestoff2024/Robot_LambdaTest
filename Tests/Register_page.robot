*** Settings ***
Resource              ../Resources/Resource_register.resource
Suite Setup           Open Home Page
Suite Teardown        Close Browsers

*** Test Cases ***

#Test passant avec tous les champs remplis correctement
The user registers to the site
    [Tags]    Register_to_site
    Enter FIRST_NAME
    Enter LAST_NAME
    Enter EMAIL
    Enter TELEPHONE
    Enter PASSWORD
    Enter CONFIRM_PASSWORD
    Click on Privacy Policy
    Click on Continue
    Registration is confirmed

#Tests avec champs vides    

The user does not enter a first name
    [Tags]    No_firstname
    Enter LAST_NAME
    Enter EMAIL
    Enter TELEPHONE
    Enter PASSWORD
    Enter CONFIRM_PASSWORD
    Click on Privacy Policy
    Click on Continue
    ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[2]/div/form/fieldset[1]/div[2]/div/div
    Log    ${message}
    Should Be Equal    ${message}    First Name must be between 1 and 32 characters!


The user does not enter a last name
    [Tags]    No_lastname
    Enter FIRST_NAME
    Enter EMAIL
    Enter TELEPHONE
    Enter PASSWORD
    Enter CONFIRM_PASSWORD
    Click on Privacy Policy
    Click on Continue
    ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[2]/div/form/fieldset[1]/div[3]/div/div
    Log    ${message}
    Should Be Equal    ${message}    Last Name must be between 1 and 32 characters!


The user does not enter an email
    [Tags]    No_email
    Enter FIRST_NAME
    Enter LAST_NAME
    Enter TELEPHONE
    Enter PASSWORD
    Enter CONFIRM_PASSWORD
    Click on Privacy Policy
    Click on Continue
    ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/fieldset[1]/div[4]/div/div
    Log    ${message}
    Should Be Equal    ${message}    E-Mail Address does not appear to be valid!


The user does not enter a telephone number
    [Tags]    No_telephone
    Enter FIRST_NAME
    Enter LAST_NAME
    Enter EMAIL
    Enter PASSWORD
    Enter CONFIRM_PASSWORD
    Click on Privacy Policy
    Click on Continue
    ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[2]/div/form/fieldset[1]/div[5]/div/div
    Log    ${message}
    Should Be Equal    ${message}    Telephone must be between 3 and 32 characters!


The user does not enter a password
    [Tags]    No_password
    Enter FIRST_NAME
    Enter LAST_NAME
    Enter EMAIL
    Enter TELEPHONE
    Enter CONFIRM_PASSWORD
    Click on Privacy Policy
    Click on Continue
    ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[2]/div/form/fieldset[2]/div[1]/div/div
    Log    ${message}
    Should Be Equal    ${message}    Password must be between 4 and 20 characters!
    ${message1}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[2]/div/form/fieldset[2]/div[2]/div/div
    Log    ${message1}
    Should Be Equal    ${message1}    Password confirmation does not match password!


The user enters invalid confirm password
    [Tags]    No_confirm_password
    Enter FIRST_NAME
    Enter LAST_NAME
    Enter EMAIL
    Enter TELEPHONE
    Enter PASSWORD
    Uncorrect password confirmation
    Click on Privacy Policy
    Click on Continue
    ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[2]/div/form/fieldset[2]/div[2]/div/div
    Log    ${message}
    Should Be Equal    ${message}    Password confirmation does not match password!

#Ne clique pas sur Politique de confidentialité.

The user does not click on Privacy Policy
    [Tags]    No_click_privacy_policy
    Enter FIRST_NAME
    Enter LAST_NAME
    Enter EMAIL
    Enter TELEPHONE
    Enter PASSWORD
    Enter CONFIRM_PASSWORD
    Click on Continue
    ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[1]
    Log    ${message}
    Should Be Equal    ${message}    Warning: You must agree to the Privacy Policy!

#Tests avec formats d'e-mail non valides    

Register with invalid email formats
    [Template]    Register user
    Christophe    Bréhal    chris.com      023456789    1478963    1478963
    Christophe    Bréhal    @tof.com       023456789    1478963    1478963
    Christophe    Bréhal    chris@tof      023456789    1478963    1478963
    Christophe    Bréhal    chris@.com     023456789    1478963    1478963
    Christophe    Bréhal    chris@         023456789    1478963    1478963


Register with data1
    Register user    ${DATA1}[0]    ${DATA1}[1]    ${DATA1}[2]    ${DATA1}[3]    ${DATA1}[4]    ${DATA1}[5]

Register with data2  
    Register user    ${DATA2}[0]    ${DATA2}[1]    ${DATA2}[2]    ${DATA2}[3]    ${DATA2}[4]    ${DATA2}[5]

Register with data3  
    Register user    ${DATA3}[0]    ${DATA3}[1]    ${DATA3}[2]    ${DATA3}[3]    ${DATA3}[4]    ${DATA3}[5]

Register with data4  
    Register user    ${DATA4}[0]    ${DATA4}[1]    ${DATA4}[2]    ${DATA4}[3]    ${DATA4}[4]    ${DATA4}[5]


Test invalid emails
    FOR   ${email}  IN  @{EMAILS}
        ${message}=    Set Variable    Test with ${FIRST_NAME} / ${LAST_NAME} / ${email} / ${TELEPHONE} / ${PASSWORD} / ${CONFIRM_PASSWORD}
        Log    ${message}    INFO
        Register user     ${FIRST_NAME}    ${LAST_NAME}    ${email}    ${TELEPHONE}    ${PASSWORD}    ${CONFIRM_PASSWORD}
    END


    


