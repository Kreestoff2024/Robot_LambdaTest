*** Settings ***
Library        SeleniumLibrary
Library        browser_options.py

*** Variables ***
${URL_main}          https://ecommerce-playground.lambdatest.io/index.php?route=common/home
${BROWSER}           Chrome        


@{DATA_billing}           Chris     Toffe    10, rue de la plage    Granville    50100
@{DATA_login}             chris@tof.com      1478963



*** Keywords ***
Open main page
    ${options}=    Get Chrome Options
    Open Browser    ${URL_main}        ${BROWSER}    options=${options}
    Set Window Size    1920    1080

Close page
    Close Browser

Choose category (printers)
    Click Element    id=entry_217832 
    Click Element    xpath=/html/body/div[1]/div[1]/div/div/nav/div/ul/li[7]/a

Click on third page
    Click Link    xpath=/html/body/div[1]/div[6]/div[1]/div[3]/div/div[1]/div[7]/div/div[1]/ul/li[3]/a

Select Apple Cinema 30
    Click Element    xpath=/html/body/div[1]/div[6]/div[1]/div[3]/div/div[1]/div[6]/div/div[4]/div/div[1]/div[1]/a/div/div[1]/img

Wait for Add to cart button to be visible
    Wait Until Element Is Visible    xpath=/html/body/div[1]/div[9]/div[1]/div[2]/div/div[2]/div[2]/div[10]/div/div[4]/div/div[2]/button

Select size
    Select From List By Value    xpath=//*[@id="input-option236-216836"]        64

Add to cart
    Click Element    id=entry_216842

Click on Buy now 
    Click Element    id=entry_216843

Click on cart
    Click Element    id=entry_217825

Click on Login
    [Documentation]        I am a registered user
    Click Element      xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div[1]/div/div[1]/div/div[1]
    #xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div[1]/div/div[1]/div/div[1]
    #/html/body/div[1]/div[5]/div[1]/div/div/form/div/div[1]/div/div[1]/div/div[1]/label
    #//*[@id="input-account-login"]
Confirm Order
    Click Button      xpath=/html/body/div[1]/div[5]/div[1]/div/div/div[4]/button/i
         #  //*[@id="button-confirm"]
         # id=button-confirm
         
Fill in the Account Login form
    [Arguments]    ${email}    ${password}
    Input Text        id=input-login-email       ${email}
    Input Password    id=input-login-password    ${password}
    Click Button      id=button-login

Agree to terms and conditions
    Click Element    xpath=//label[@for="input-agree"]
#//*[@id="input-agree"]//*[@id="form-checkout"]/div/div[2]/div/div[5]
Use Existing Address
    Click Element    id=input-payment-address-existing


Click Continue
    Click Element    xpath=//*[@id="button-save"]

Close terms popup window
    Click Element    xpath=//*[@id="modal-agree"]/div/div/div[1]/button
Remove items
    Click Element    xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div[2]/div/div[1]/div[1]/table/tbody/tr/td[3]/div/div/button[2]

Fill in the Billing Address form
    [Arguments]    ${firstname}    ${lastname}    ${adress1}    ${city}    ${postcode}
    Input Text    id=input-payment-firstname    ${firstname}
    Input Text    id=input-payment-lastname     ${lastname}
    Input Text    id=input-payment-address-1    ${adress1}
    Input Text    id=input-payment-city         ${city}
    Input Text    id=input-payment-postcode     ${postcode}
    Select From List By Value    id=input-payment-country     74
    Select From List By Value    id=input-payment-zone        1164
    Click Element    id=input-agree
    Click Button     id=button-save
Get the picture address of a product
    [Documentation]        Looks for a product on the page (from its ID number), and sends back the address of its picture
    #[Arguments]            ${ID}
    Click Element          id=entry_218387
    ${picture_address}     Get Element Attribute    xpath=/html/body/div[1]/div[9]/div[1]/div[2]/div/div[2]/div[1]/div[1]/div/div[1]/a/img       src 
    RETURN                 ${picture_address}


    