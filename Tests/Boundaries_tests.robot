*** Settings ***
Resource              ../Resources/Resource_boundaries.resource
Test Setup           Open Home Page
Test Teardown        Close Browser

*** Test Cases ***


Test Invalid Firstame Lengths
    @{FIRST_NAMES}=    Create List    0        33        

    FOR    ${length}    IN    @{FIRST_NAMES}
        ${firstname}=    Generate Random String    ${length}    [LETTERS]
        ${message}=    Set Variable    Test with length=${length} -> ${firstname}
        Log    ${message}    INFO

        All Fields
        ...    ${firstname}
        ...    ${LAST_NAME}
        ...    ${EMAIL}
        ...    ${TELEPHONE}
        ...    ${PASSWORD}
        ...    ${CONFIRM_PASSWORD}
        ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[2]/div/form/fieldset[1]/div[2]/div/div
        
        Should Be Equal    ${message}        First Name must be between 1 and 32 characters!
    END

Test Valid Firstame Lengths
    @{FIRST_NAMES}=    Create List        1        2        31        32        

    FOR    ${length}    IN    @{FIRST_NAMES}
        ${firstname}=    Generate Random String    ${length}    [LETTERS]
        ${message}=    Set Variable    Test with length=${length} -> ${firstname}
        Log    ${message}    INFO

        All Fields
        ...    ${firstname}
        ...    ${LAST_NAME}
        ...    ${EMAIL}
        ...    ${TELEPHONE}
        ...    ${PASSWORD}
        ...    ${CONFIRM_PASSWORD}
        ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[1]
        
        Should Match Regexp    ${message}
        ...    Warning: E-Mail Address is already registered!|  Warning: You must agree to the private policy!

    END

Test Invalid Lastame Lengths
    @{LAST_NAMES}=    Create List    0        33        

    FOR    ${length}    IN    @{LAST_NAMES}
        ${lastname}=    Generate Random String    ${length}    [LETTERS]
        ${message}=    Set Variable    Test with length=${length} -> ${lastname}
        Log    ${message}    INFO

        All Fields
        ...    ${FIRST_NAME}
        ...    ${lastname}
        ...    ${EMAIL}
        ...    ${TELEPHONE}
        ...    ${PASSWORD}
        ...    ${CONFIRM_PASSWORD}
        ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[2]/div/form/fieldset[1]/div[3]/div/div
        
        Should Be Equal    ${message}        Last Name must be between 1 and 32 characters!
    END

Test Valid Lastname Lengths
    @{LAST_NAMES}=    Create List        1        2        31        32        

    FOR    ${length}    IN    @{LAST_NAMES}
        ${lastname}=    Generate Random String    ${length}    [LETTERS]
        ${message}=    Set Variable    Test with length=${length} -> ${lastname}
        Log    ${message}    INFO

        All Fields
        ...    ${FIRST_NAME}
        ...    ${lastname}
        ...    ${EMAIL}
        ...    ${TELEPHONE}
        ...    ${PASSWORD}
        ...    ${CONFIRM_PASSWORD}
        
        ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[1]
        
        Should Match Regexp    ${message}
        ...    Warning: E-Mail Address is already registered!|  Warning: You must agree to the private policy!

    END  

Test Invalid Telephone Lengths
    @{TELEPHONES}=    Create List    2        33        

    FOR    ${length}    IN    @{TELEPHONES}
        ${telephone}=    Generate Random String    ${length}    [NUMBERS]
        ${message}=    Set Variable    Test with length=${length} -> ${telephone}
        Log    ${message}    INFO

        All Fields
        ...    ${FIRST_NAME}
        ...    ${LAST_NAME}
        ...    ${EMAIL}
        ...    ${telephone}
        ...    ${PASSWORD}
        ...    ${CONFIRM_PASSWORD}

        ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[2]/div/form/fieldset[1]/div[5]/div/div
        
        Should Be Equal    ${message}        Telephone must be between 3 and 32 characters!
    END

Test Valid Telephone Lengths
    @{TELEPHONES}=    Create List        3        4        31        32        

    FOR    ${length}    IN    @{TELEPHONES}
        ${telephone}=    Generate Random String    ${length}    [NUMBERS]
        ${message}=    Set Variable    Test with length=${length} -> ${telephone}
        Log    ${message}    INFO

        All Fields
        ...    ${FIRST_NAME}
        ...    ${LAST_NAME}
        ...    ${EMAIL}
        ...    ${telephone}
        ...    ${PASSWORD}
        ...    ${CONFIRM_PASSWORD}

        ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[1]
        
        Should Match Regexp    ${message}
        ...    Warning: E-Mail Address is already registered!|  Warning: You must agree to the private policy!

    END

Test Invalid Password Lengths
    @{PASSWORDS}=    Create List    3        21               

    FOR    ${length}    IN    @{PASSWORDS}
        ${password}=    Generate Random String    ${length}    [NUMBERS]
        ${message}=    Set Variable    Test with length=${length} -> ${password}
        Log    ${message}    INFO

        All Fields
        ...    ${FIRST_NAME}
        ...    ${LAST_NAME}
        ...    ${EMAIL}
        ...    ${TELEPHONE}
        ...    ${password}
        ...    ${CONFIRM_PASSWORD}

        ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[2]/div/form/fieldset[2]/div[1]/div/div
        
        Should Be Equal    ${message}        Password must be between 4 and 20 characters!
    END

   #Bug detected with 21+ digits on password length
Test Valid Password Lengths
    @{PASSWORDS}=    Create List        4        5        19        20        

    FOR    ${length}    IN    @{PASSWORDS}
        ${password}=    Generate Random String    ${length}    [NUMBERS]
        ${message}=    Set Variable    Test with length=${length} -> ${password}
        Log    ${message}    INFO

        All Fields
        ...    ${FIRST_NAME}
        ...    ${LAST_NAME}
        ...    ${EMAIL}
        ...    ${TELEPHONE}
        ...    ${password}
        ...    ${CONFIRM_PASSWORD}

        ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[1]
        
        Should Match Regexp    ${message}
        ...    Warning: E-Mail Address is already registered!|  Warning: You must agree to the private policy!

    END


Test Invalid Confirm Passwords
    [Template]    Confirm Password Field
    Christophe    Bréhal    chris@tof.com       023456789    1478963    1
    Christophe    Bréhal    chris@tof.com       023456789    1478963    147896
    Christophe    Bréhal    chris@tof.com       023456789    1478963    14789634    
    