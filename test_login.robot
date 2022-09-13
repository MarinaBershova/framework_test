*** Settings ***
Library  SeleniumLibrary
Documentation  Suite description #automated tests for scout website


*** Variables ***
${LOGIN URL}        https://scouts.futbolkolektyw.pl/en/
${BROWSER}      Chrome
${SIGININBUTTON}      xpath=//*[@type='submit']
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}    xpath=//*[@name='password']
${PAGELOGO}     xpath=//*[@id="__next"]/div[1]/header/div/h6
${SIGNOUTBUTTON}    xpath=//*[@id="__next"]/div[1]/div/div/div/ul[2]/div[2]/div[2]/span
${WARNINGMESSAGE}   xpath=//*[text()='Please provide your username or your e-mail.']
${LANGUAGEBUTTON}   xpath=(//span[contains(@class, 'MuiTypography-root')])[3]
${ADDPLAYERBUTTON}  xpath=//*[text()='Add player']
${PLAYERNAME}       xpath=// *[ @ name='name']
${PLAYERSURNAME}        xpath=//*[@name='surname']
${PLAYERAGE}        xpath=//*[@name='age']
${PLAYERMAINPOSITION}       xpath=//*[@name='mainPosition']
${NEWPLAYER}        xpath=//*[@id="__next"]/div[1]/div/div/div/ul[2]/div[1]/div[2]/span
${CLEARBUTTON}  xpath=//*[text()='Clear']
${WARNINGMESSAGEADDPLAYER}  xpath=//*[text()='Required']
*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    [Teardown]  Close browser

Log out of the system
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Wait until dashboard is visible
    Click on the Sign out button
    [Teardown]  Close browser

Invalid login in to the system
    Open login page
    Click on the Submit button
    Assert warning message
    [Teardown]  Close browser

Change language into the system
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Wait until dashboard is visible
    Click on the Language button
    Assert language button
    [Teardown]  Close browser

Add player to the database
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Wait until dashboard is visible
    Click on the Add player button
    Tipe in player name
    Tipe in player surname
    Tipe in player age
    Tipe in player main position
    Click on the Submit button
    Assert new player
    [Teardown]  Close browser

Clear fields on add player page
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Wait until dashboard is visible
    Click on the Add player button
    Tipe in player name
    Tipe in player surname
    Tipe in player age
    Tipe in player main position
    Click on the Clear button
    Assert warning message empty fields
    [Teardown]  Close browser


*** Keywords ***
Open login page
    Open Browser        ${LOGIN URL}        ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in email
    Input Text      ${EMAILINPUT}   user07@getnada.com
Type in password
    Input Text      ${PASSWORDINPUT}   Test-1234
Click on the Submit button
    Click Element       ${SIGININBUTTON}
Assert dashboard
    wait until element is visible       ${PAGELOGO}
    title should be     Scouts panel
    Capture Page Screenshot     alert.png
Click on the Sign out button
    Click Element   ${SIGNOUTBUTTON}
Wait until dashboard is visible
    wait until element is visible       ${PAGELOGO}
Assert warning message
    wait until element is visible       ${WARNINGMESSAGE}
    Element Text Should Be    ${WARNINGMESSAGE}     Please provide your username or your e-mail.
Click on the Language button
    Click Element   ${LANGUAGEBUTTON}
Assert language button
    wait until element is visible       ${LANGUAGEBUTTON}
    Element Text Should Be      ${LANGUAGEBUTTON}   English
Click on the Add player button
    Click Element   ${ADDPLAYERBUTTON}
Tipe in player name
    Input Text      ${PLAYERNAME}   Leon
Tipe in player surname
    Input Text      ${PLAYERSURNAME}    King
Tipe in player age
    Input Text      ${PLAYERAGE}    01012002
Tipe in player main position
    Input Text      ${PLAYERMAINPOSITION}   goalkeeper
Assert new player
    Wait Until Page Contains     Leon King
    Element Text Should Be      ${NEWPLAYER}   Leon King
Click on the Clear button
    Click Element       ${CLEARBUTTON}
Assert warning message empty fields
    wait until element is visible       ${WARNINGMESSAGEADDPLAYER}
    Element Text Should Be    ${WARNINGMESSAGEADDPLAYER}     Required
