*** Settings ***
Library        SeleniumLibrary


*** Variables ***
${URL}            https://ecommerce-playground.lambdatest.io/index.php?route=account/login
${BROWSER}        Chrome

${EMAIL}          chris@tof.com
${PASSWORD}       1478963 

@{DATA1}          chris@tof.com
@{DATA2}          kris@egf.com


*** Keywords ***
Open Login Page
    Open Browser        ${URL}        ${BROWSER}

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

    
