*** Settings ***
Library        RequestsLibrary
Library        Collections
Suite Setup    Run Keywords
...            Create Session should succeed    AND
...            Should be able to login


*** Variables ***
${LOGIN_ENDPOINT}      /users/login
${CONTACT_ENDPOINT}    /contacts
${USR_ENDPOINT}        /users

*** Test Cases ***
Should be able to add new user
    [Tags]    add user
    ${verify}=      Create Dictionary    Authorization=${token}
    ${body}=        Create Dictionary    firstName=Test1    lastName=User1    email=test1.user1@fakemail.com    password=1234567    token=${verify}
    ${response}=    Post On Session    contactList    ${USR_ENDPOINT}    json=${body}    expected_status=201
    Should Contain    ${response.text}    test1.user1@fakemail.com

Should be able to add contacts
    [Tags]    add contacts
    ${verify}=    Create Dictionary    Authorization=${token}
    ${body}=      Create Dictionary    firstName=Test2    lastName=User2    birthdate=1970-01-01    email=test2.fake2@fakemail.com
    ...                                phone=123456789    street1=Main Street    street2=Apartment A    city=K Town    stateProvince=KT    
    ...                                postalCode=11223    country=Finland
    ${response}=    Post On Session    contactList    ${CONTACT_ENDPOINT}    headers=${verify}    json=${body}    expected_status=201
    Should Contain    ${response.text}    test2.fake2@fakemail.com
    ${id}=    Get From Dictionary    ${response.json()}    _id    0
    Set Suite Variable    ${id}

Should be able to update contacts
    [Tags]    update contacts
    ${verify}=    Create Dictionary    Authorization=${token}
    ${body}=      Create Dictionary    firstName=Test3    lastName=User3    birthdate=1970-01-02    email=test3.fake3@fakemail.com
    ...                                phone=123456780    street1=Main Street    street2=Apartment B    city=K Town    stateProvince=KT    
    ...                                postalCode=11223    country=Finland
    ${response}=    Put On Session     contactList    ${CONTACT_ENDPOINT}/${id}    headers=${verify}    json=${body}    expected_status=200
    Should Contain    ${response.text}    test3.fake3@fakemail.com

Should be able to delete contacts
    [Tags]    delete contact
    ${verify}=    Create Dictionary    Authorization=${token}
    ${response}=    Get On Session     contactList    ${CONTACT_ENDPOINT}    headers=${verify}    expected_status=any


Should be able to delete user
    [Tags]    delete user
    ${verify}=      Create Dictionary    Authorization=${token}
    Log    ${verify}
    Delete On Session    contactList    ${USR_ENDPOINT}/me    headers=${verify}    expected_status=200
    

*** Keywords ***
Create Session should succeed
    Create Session    contactList    https://thinking-tester-contact-list.herokuapp.com    verify=True
    
Should be able to login
    [Tags]    login
    ${body}=        Create Dictionary    email=test1.user1@fakemail.com    password=1234567
    ${response}=    Post On Session    contactList    ${LOGIN_ENDPOINT}    json=${body}    expected_status=200
    Dictionary Should Contain Key    ${response.json()}    token
    ${token}=    Get From Dictionary    ${response.json()}    token    0
    Log    ${token}
    Set Suite Variable    ${token}

    
    
    