*** Settings ***
Library        SeleniumLibrary
Library        browser_options.py

*** Variables ***
${URL}                    https://ecommerce-playground.lambdatest.io/index.php?route=account/login
${URL_Account}            https://ecommerce-playground.lambdatest.io/index.php?route=account/account
${URL_Account_Logout}     https://ecommerce-playground.lambdatest.io/index.php?route=account/logout
${BROWSER}                Chrome        

${EMAIL}          chris@tof.com
${PASSWORD}       1478963 

@{DATA1}          chris@tof.com
@{DATA2}          kris@egf.com



*** Keywords ***
Open Login Page
    ${options}=         Get Chrome Options
    Open Browser        ${URL}        ${BROWSER}    options=${options}

Close Page
    Close Browser

Enter Email
    Input Text        id=input-email        chris@tof.com

Enter Password
    Input Password    id=input-password     1478963

Click on login
    Click Button      xpath=/html/body/div[1]/div[5]/div[1]/div/div/div/div[2]/div/div/form/input

Click on Forgotten Password
    Click Link    xpath=/html/body/div[1]/div[5]/div[1]/div/div/div/div[2]/div/div/form/div[2]/a

Click on Continue
    Click Button    xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div[2]/button

Login is confirmed
    ${message}        Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div/div/div[3]/h2
    Should Be Equal    ${message}    My Affiliate Account

All Fields
    [Arguments]       ${email}    ${password}
    Input Text        id=input-email       ${email}
    Input Password    id=input-password    ${password}
    Click Button      xpath=/html/body/div[1]/div[5]/div[1]/div/div/div/div[2]/div/div/form/input
    Sleep    2s
    ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[1]
    Log    ${message}   
    Should Be Equal    ${message}         Warning: No match for E-Mail Address and/or Password.

Forgot Password Email Field
    [Arguments]       ${email}
    Click Link        xpath=/html/body/div[1]/div[5]/div[1]/div/div/div/div[2]/div/div/form/div[2]/a
    Input Text        xpath=//*[@id="input-email"]    ${email}
    Click Button      xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div[2]/button
    Sleep    2s

Login as
    [Documentation]    Fill in the login form and submit it
    [Arguments]        ${email}        ${password}
    Element Should Be Visible    xpath=/html/body/div[1]/div[5]/div[1]/div/div/div/div[2]/div/div/form/input        message=We are not on the login page 
    Input Text        id=input-email           ${email}
    Input Password    id=input-password        ${password}
    Click Button       xpath=/html/body/div[1]/div[5]/div[1]/div/div/div/div[2]/div/div/form/input

Login must be accepted
    [Documentation]    Verify that the login form that just been sent resulted to a success and to redirection to the Account page 
    Element Should Not Be Visible    xpath=/html/body/div[1]/div[5]/div[1]/div/div/div/div[2]/div/div/form/input        message=We are still on the login page 
    Element Text Should Be           xpath=/html/body/div[1]/div[5]/div[1]/div/aside/div/a[14]    Logout
    ...                              message=the login did not redirect to the account page 
    Location Should Be               ${URL_Account}
    ...                              message=the login did not redirect to the right address
    

Page must contain ${element_number} elements
    [Documentation]    Verify that the page displays the right number of elements
    [Arguments]           ${element_number}
    Location Should Be    ${URL_Account}
    ...                   message=We are not on the account page 
    ${elements}           Get WebElements       class=account-account
    Length Should Be      ${elements}           ${element_number}
    FOR    ${emt}    IN    @{elements}
        Run Keyword And Continue On Failure
        ...                            Element Should Be Visible        ${emt}
        ...                            message=an element is present, but not visible
    END

Delete the status of the site and log out
    [Documentation]    This keyword is to be used in Teardown. It resets the status of the site, as if we just opened the browser
    ${URL_Account}        Run Keyword And Return Status    Location Should Be    ${URL}
    IF   ${URL_Account}
         Reload Page
         Clear Element Text    id=input-email
         Clear Element Text    id=input-password 
    ELSE
        Click Link            xpath=/html/body/div[1]/div[5]/div[1]/div/aside/div/a[14]
        Click Link            xpath=/html/body/div[1]/div[5]/header/div[3]/div[1]/div/div[3]/nav/div/ul/li[6]/a
        Location Should Be    ${URL}
    END

