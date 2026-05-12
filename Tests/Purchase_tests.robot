*** Settings ***
Resource              ../Resources/Resource_purchase.resource
Test Setup           Open main page
Test Teardown        Close page

*** Test Cases ***

Picture assertion Test    
    ${src}         Get the picture address of a product    
    Log            ${src}

Add to cart Test
    [Tags]    add_to_cart_test
    Choose category (printers)
    Click on third page
    Select Apple Cinema 30
    Select size
    Add to cart
    Sleep    2s
    Add to cart
    Click on cart
    Wait Until Element Is Visible    xpath=/html/body/div[1]/div[3]/div/div[1]/div/table/tbody/tr/td[2]/small[1]
    ${message}        Get Text       xpath=/html/body/div[1]/div[3]/div/div[1]/div/table/tbody/tr/td[2]/small[1]
    Should Be Equal   ${message}     Model: Product 15

Purchase an item
    [Tags]    purchase_item
    Choose category (printers)
    Click on third page
    Select Apple Cinema 30
    Select size
    Sleep    2s
    Click on Buy now
    Sleep    2s
    Click on Login
    Fill in the Account Login form      @{DATA_login}
    Sleep    2s
    Use Existing Address
    Agree to terms and conditions
    Double Click Element    xpath=//*[@id="button-save"]
    Wait Until Element Is Visible    css=.page-title
    Confirm Order
    Wait Until Element Is Visible    css=.buttons > a:nth-child(1)
    ${message}    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div/div/p[2]
    Should Be Equal    ${message}    Your order has been successfully processed!


Remove Items from cart
    [Tags]    remove_items
    Choose category (printers)
    Click on third page
    Select Apple Cinema 30
    Select size
    Sleep    2s
    Click on Buy now
    Wait Until Element Is Visible    xpath=/html/body/div[1]/div[5]/div[1]/div/div/form/div/div[2]/div/div[1]/div[1]/table/tbody/tr/td[3]/div/div/button[2]
    Remove items
    Wait Until Element Is Visible    xpath=/html/body/div[1]/div[5]/div[1]/div/div/h1
    ${message}    Get Text    id=content
    Should Contain    ${message}    Your shopping cart is empty!

