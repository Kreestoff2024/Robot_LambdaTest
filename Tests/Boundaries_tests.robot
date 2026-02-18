*** Settings ***
Resource              ../Resources/Boundaries_resources.robot
Suite Setup           Open Home Page
Suite Teardown        Close Browser

*** Test Cases ***


Test Invalid Firstame Lengths
    @{FIRST_NAMES}=    Create List    0        33        

    FOR    ${length}    IN    @{FIRST_NAMES}
        ${firstname}=    Generate Random String    ${length}    [LETTERS]
        ${message}=    Set Variable    Test with length=${length} -> ${firstname}
        Log    ${message}    INFO

        Firstname Field
        ...    ${firstname}
        ...    ${LAST_NAME}
        ...    ${EMAIL}
        ...    ${TELEPHONE}
        ...    ${PASSWORD}
        ...    ${CONFIRM_PASSWORD}

        Should Not Be Empty    ${message}
    END

Test Valid Firstame Lengths
    @{FIRST_NAMES1}=    Create List        1        2        31        32        

    FOR    ${length}    IN    @{FIRST_NAMES1}
        ${firstname}=    Generate Random String    ${length}    [LETTERS]
        ${message}=    Set Variable    Test with length=${length} -> ${firstname}
        Log    ${message}    INFO

        Firstname Field
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

        Lastname Field
        ...    ${FIRST_NAME}
        ...    ${lastname}
        ...    ${EMAIL}
        ...    ${TELEPHONE}
        ...    ${PASSWORD}
        ...    ${CONFIRM_PASSWORD}

        Should Not Be Empty    ${message}
    END

Test Valid Lastname Lengths
    @{LAST_NAMES}=    Create List        1        2        31        32        

    FOR    ${length}    IN    @{LAST_NAMES}
        ${lastname}=    Generate Random String    ${length}    [LETTERS]
        ${message}=    Set Variable    Test with length=${length} -> ${lastname}
        Log    ${message}    INFO

        Firstname Field
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

