*** Settings ***
Library    SeleniumLibrary    
Library    Collections 
Resource    BaseResource.robot


*** Variables ***
${landing_title}    Online Shopping for Women, Men, Kids Fashion & Lifestyle - Myntra



*** Keywords ***
user is on landing page
    Title Should Be    ${landing_title}
    

user click on login link
    ${profile}=    Read element    LoginPage.profile_xpath
    Element Should Be Visible    xpath=${profile}    
    Mouse Over    xpath=${profile}
    ${login}=    Read element    LoginPage.Login/SignUp_xpath
    Page Should Contain Element    xpath=${login}    
    Element Should Be Visible    xpath=${login}    
    Click Element    xpath=${login}    
    
login page is displayed
    ${mob}=    Read element    LoginPage.mobileno
    Element Should Be Visible    xpath=${mob}   
    
user enters mob no
    [Arguments]    ${mno}
    ${mobTF}=    Read element    LoginPage.mobileno
    Input Text    ${mobTF}    ${mno}
    ${continue}=    Read element    LoginPage.continue_btn
    Click Element    xpath=${continue}    
    
proper error msg is displayed
    ${err}=    Read element    LoginPage.error_msg
    Element Should Be Visible    xpath=${err}    
        
Test Login with invalid mob no
    [Arguments]    ${mobno}
    
    Given Launch app maximize window and set timeout
    And user is on landing page
    When user click on login link 
    When login page is displayed
    When user enters mob no  ${mobno}
    Then proper error msg is displayed
    Then Close All Browsers

