*** Settings ***
Documentation   Reservation test suite
Library         SeleniumLibrary
Resource        variables.resource

*** Keywords ***
Open Application
    Open Browser      ${URL}   ${BROWSER}

Go To Reservation Page
    Click Element   id:reserve__link

Fill Reservation Form Information
    Input Text                 id:citizen_id     ${CITIZEN_ID}
    Select From List By Value  id:site_name      ${SITE_NAME}
    Select From List By Value  id:vaccine_name   ${VACCINE_NAME}

Fill Info Form Infomation
    Input Text   id:citizen_id     ${CITIZEN_ID}

Go To Info Page
    Click Element   id:nav__info__link

*** Test Cases ***
Verify 2 Items On Home Page
    Open Application
    Title Should Be       Vaccine Haven
    Page Should Contain   Vaccine Haven
    Page Should Contain   Vaccine for everyone

Create A Reservation
    Go To Reservation Page
    Fill Reservation Form Information
    Click Element               id:reserve__btn

Verify Reservation Is Created
    Go To Info Page
    Fill Info Form Infomation
    Wait Until Page Contains Element   id:info__btn
    Click Element                      id:info__btn
    Wait Until Page Contains           ${CITIZEN_ID}
    Page Should Contain                ${CITIZEN_ID}
    Page Should Contain                ${SITE_NAME}
    Page Should Contain                ${VACCINE_NAME}

Cancel A Reservation
    Wait Until Page Contains Element   id:cancel__btn
    Click Element                      id:cancel__btn

Verify Reservation Is Deleted
    Go To Info Page
    Fill Info Form Infomation
    Wait Until Page Contains Element   id:info__btn
    Click Element                      id:info__btn
    Wait Until Page Contains           ${CITIZEN_ID}
    Page Should Not Contain            ${SITE_NAME}
    [Teardown]                         Close Browser