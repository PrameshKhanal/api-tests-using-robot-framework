*** Settings ***
Library        RequestsLibrary
Library        Collections
Suite Setup    Create Session    contactList    
...            https://thinking-tester-contact-list.herokuapp.com
...            verify=True


*** Variables ***
${LOGIN_ENDPOINT}      /users/login
${CONTACT_ENDPOINT}    /contacts
${USR_ENDPOINT}        /users

*** Test Cases ***
Should be able to login
    [Tags]    login
    ${body}=        Create Dictionary    email=test1.user1@fakemail.com    password=1234567
    ${response}=    Post On Session    contactList    ${LOGIN_ENDPOINT}    json=${body}    expected_status=200
    Dictionary Should Contain Key    ${response.json()}    token
    ${token}=    Get From Dictionary    ${response.json()}    token
    Log    ${token}
    Set Suite Variable    ${token}

Should be able to add new user
    [Tags]    add user
    ${verify}=      Create Dictionary    Authorization=${token}
    ${body}=        Create Dictionary    firstName=Test1    lastName=User1    email=test1.user1@fakemail.com    password=1234567    token=${verify}
    ${response}=    Post On Session    contactList    ${USR_ENDPOINT}    json=${body}    expected_status=201
    Should Contain    ${response.text}    test1.user1@fakemail.com

Should be able to delete user
    [Tags]    delete user
    ${verify}=      Create Dictionary    Authorization=${token}
    Log    ${verify}
    Delete On Session    contactList    ${USR_ENDPOINT}/me    headers=${verify}    expected_status=200
    

*** Keywords ***



    
    
    