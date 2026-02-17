*** Settings ***
Resource              ../Resources/Boundaries_resources.robot
Suite Setup           Open Home Page
Suite Teardown        Close Browser

*** Test Cases ***


Boundaries Test Name (0)
    [Tags]    0_characters
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


Test Invalid Name Lengths
    @{FIRST_NAMES}=    Create List    0        33        

    FOR    ${length}    IN    @{FIRST_NAMES}
        ${firstname}=    Generate Random String    ${length}    [LETTERS]
        ${message}=    Set Variable    Test with length=${length} -> ${firstname}
        Log    ${message}    INFO

        Invalid Boundaries Name
        ...    ${firstname}
        ...    ${LAST_NAME}
        ...    ${EMAIL}
        ...    ${TELEPHONE}
        ...    ${PASSWORD}
        ...    ${CONFIRM_PASSWORD}

        Should Not Be Empty    ${message}
    END

Test Valid Name Lengths
    @{FIRST_NAMES1}=    Create List        31        32        

    FOR    ${length}    IN    @{FIRST_NAMES1}
        ${firstname}=    Generate Random String    ${length}    [LETTERS]
        ${message}=    Set Variable    Test with length=${length} -> ${firstname}
        Log    ${message}    INFO

        Invalid Boundaries Name
        ...    ${firstname}
        ...    ${LAST_NAME}
        ...    ${EMAIL}
        ...    ${TELEPHONE}
        ...    ${PASSWORD}
        ...    ${CONFIRM_PASSWORD}

        ${message}=    Get Text    xpath=/html/body/div[1]/div[5]/div[1]/div[1]
        Log    ${message}
        Should Be Equal    ${message}    Warning: E-Mail Address is already registered!   
    END


    

