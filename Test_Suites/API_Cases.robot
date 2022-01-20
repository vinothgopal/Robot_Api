*** Settings ***
Suite Setup    Session for Rest Api
Suite Teardown    Delete the user   ${user_Id}
Resource     ../resources/api_keywords.robot
*** Variables ***
${new_user_email}    sktest@gmail.com
${update_user_mail}  updatesk@kdm.com
*** Test Cases ***
Create user and verify details
    [Documentation]    this testcases used to create new user using post request and verfiy status code and responce.
    [Tags]    Smoke    Regression
    Create User through API    ${new_user_email}
    Verify New user responce   ${new_user_email}

Get user details and verify the responce
    [Documentation]    this testcases used to fetch user detail  using user id and verfiy status code and responce.
    [Tags]    Smoke    Regression
    Get User Details using ID   ${user_Id}
    Verify New user responce    ${new_user_email}

Update user email and verify the responce
    [Documentation]    this testcases used to update user detail  using user id and new mail id then verfiy status code and responce.
    [Tags]    Smoke    Regression
    Update user details using id   ${user_Id}   ${update_user_mail}
    Verify New user responce    ${update_user_mail}

Create user using json file
    [Documentation]    this testcases we are using body from external json file.
    [Tags]    Smoke    Regression
    Create User using json file