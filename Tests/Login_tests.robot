*** Settings ***
Resource           ../Resources/Resource_login.resource

Suite Setup        Open Login Page
#Test Teardown      Delete the status of the site and log out
Suite Teardown     Close Browser

*** Test Cases ***

#Test passant
Login to account
    [Tags]    login_to_account
    Enter Email
    Enter Password
    Click on login
    Sleep    2s
    ${message}        Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div/aside/div/a[14]
    Should Be Equal    ${message}    Logout

Login and Logout
    [Tags]    login_and_logout
    Input Text                       id=input-email       chris@tof.com
    Input Password                   id=input-password    1478963
    Click Button                     xpath=/html/body/div[1]/div[5]/div[1]/div/div/div/div[2]/div/div/form/input
    Wait Until Element Is Visible    xpath=/html/body/div[1]/div[5]/div[1]/div/aside/div/a[14]
    Click Link                       Logout
    Page Should Contain              Account Logout 

Login Test
    Login as    chris@tof.com    1478963
    Sleep    2s
    Login must be accepted
    Page must contain 1 elements    1


#Tests non passants

The user does not enter an email
    [Tags]    empty_email_field
    Enter Password
    Click on login
    Sleep    2s
    ${message}        Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[1]
    Should Match Regexp    ${message}
        ...    Warning: No match for E-Mail Address and/or Password.|   Warning: Your account has exceeded allowed number of login attempts. Please try again in 1 hour.
        ...    

The user does not enter a password
    [Tags]    empty_password_field
    Enter Email
    Click on login
    Sleep    2s
    ${message}        Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[1]
    Should Match Regexp    ${message}
        ...    Warning: No match for E-Mail Address and/or Password.|   Warning: Your account has exceeded allowed number of login attempts. Please try again in 1 hour.

The user does not enter an email and a password
    [Tags]    empty_email_and_password_fields
    Click on login
    Sleep    2s
    ${message}        Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[1]
    Should Match Regexp    ${message}
        ...    Warning: No match for E-Mail Address and/or Password.|   Warning: Your account has exceeded allowed number of login attempts. Please try again in 1 hour.

Test not matching emails
    [Template]    All Fields
    chris@efg.com        1478963
    kris@tof.com         1478963

Test not matching passwords
    [Template]    All Fields
    chris@tof.com        14789632
    chris@tof.com        147896


#Mot de passe oublié


The user enters a registered email
    Forgot Password Email Field    ${DATA1}[0]
    ${message}        Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[1]
    Should Be Equal    ${message}     An email with a confirmation link has been sent your email address.

The user enters an unknown email
    Forgot Password Email Field    ${DATA2}[0]
    ${message}        Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[1]
    Should Be Equal    ${message}     Warning: The E-Mail Address was not found in our records, please try again!
