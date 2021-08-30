*** Settings ***
Documentation       Simple example using SeleniumLibrary.
Library             SeleniumLibrary
Library             OperatingSystem

*** Variables ***
${Chrome_URL}           https://www.google.co.th/
${BROWSER}              Chrome
${txtboxSearch}         //input[@name="q"]
${btnSearch}            //div[@class='FPdoLc lJ9FBc']//input[@name='btnK']


*** Keywords ***  
Open Chrome Browser
  Open Browser    ${Chrome_URL}    ${BROWSER}
  Maximize Browser Window

Input Text For Search
    [Arguments]    ${text}
    Wait Until Element Is Visible    ${txtboxSearch}
    Input Text    ${txtboxSearch}    ${text}
    Wait Until Element Is Visible    //span[contains(text(),'สัตว์')]/../..//span[text()='${text}']

Click Search Button
    Wait Until Page Contains Element    ${btnSearch}
    Press Keys    NONE    RETURN
    Wait Until Element Is Not Visible    ${btnSearch}

Check Result Displayed
  [Arguments]    ${expect}
  ${isVisible}    Run Keyword And Return Status    Page Should Contain    ${expect}
  Run Keyword If    ${isVisible}==True    Element Should Be Visible    //h3[contains(text(),'${expect} - วิกิพีเดีย')]
  Run Keyword If    ${isVisible}==False    Element Should Not Be Visible    //h3[contains(text(),'${expect} - วิกิพีเดีย')]

*** Test Cases ***
Verify Search Success
    Open Chrome Browser
    Input Text For Search    แมว
    Click Search Button
    Check Result Displayed    แมว

    [Teardown]    Close Browser

Verify Search Fail
    Open Chrome Browser
    Input Text For Search    สุนัข
    Click Search Button
    Check Result Displayed    แมว

    [Teardown]    Close Browser