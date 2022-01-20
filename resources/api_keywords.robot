*** Settings ***
Library           RequestsLibrary
Resource      ../Config.txt
Library    JSONLibrary
*** Keywords ***
Session for Rest Api
    &{head}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${TOKEN}
    Create Session    demo_api    ${Base_URL}    headers=${head}    verify=true

Create User through API
    [Arguments]    ${email_id}
    ${user_body} =    Catenate    SEPARATOR=    {    "name": "Mr.Robot",    "gender":"Male",    "email":"${email_id}",    "status": "active"    }
    ${user_res}=    post on session    demo_api    /public/v1/users    data=${user_body}
    log    ${user_res.content}
    Should Be Equal As Strings    ${user_res.status_code}    201
    Set Suite Variable    ${NewUserdata}   ${user_res.json()}
    Set Suite Variable    ${user_Id}   ${NewUserdata["data"]["id"]}

Get User Details using ID
    [Arguments]    ${user_id}
    ${user_res}=    get on session    demo_api    /public/v1/users/${user_id}
    log    ${user_res.content}
    Should Be Equal As Strings    ${user_res.status_code}    200
    Set Suite Variable    ${NewUserdata}   ${user_res.json()}

Update user details using id
    [Arguments]    ${user_id}  ${newmail}
    ${user_body} =    Catenate    SEPARATOR=    {    "name": "Mr.Robot",    "gender":"Male",    "email":"${newmail}",    "status": "active"    }
    ${user_res}=    put on session    demo_api    /public/v1/users/${user_id}    data=${user_body}
    log    ${user_res.content}
    Should Be Equal As Strings    ${user_res.status_code}    200
    Set Suite Variable    ${NewUserdata}   ${user_res.json()}
    Set Suite Variable    ${user_Id}   ${NewUserdata["data"]["id"]}

Verify New user responce
    [Arguments]    ${email_id}
    Should Be Equal As Strings    Mr.Robot    ${NewUserdata["data"]["name"]}
    Should Be Equal As Strings    male    ${NewUserdata["data"]["gender"]}
    Should Be Equal As Strings    ${email_id}    ${NewUserdata["data"]["email"]}
    Should Be Equal As Strings    active    ${NewUserdata["data"]["status"]}

Delete the user
    [Arguments]    ${user_id}
    ${user_res}=    delete on session    demo_api    /public/v1/users/${user_id}
    log    ${user_res.content}
    Should Be Equal As Strings    ${user_res.status_code}    204

Create User using json file
    ${user_body}=    load json from file    ${Create_userJson}
    ${user_res}=    post on session    demo_api    /public/v1/users    json=${user_body}
    log    ${user_res.content}
    Should Be Equal As Strings    ${user_res.status_code}    201
    ${res}   Set variable       ${user_res.json()}
    Delete the user    ${res["data"]["id"]}

