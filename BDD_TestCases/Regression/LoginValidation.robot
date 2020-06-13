*** Settings ***
Resource    ../../BDD_Resources/BaseResource.robot
Resource    ../../BDD_Resources/LandingPage.robot
Test Setup    Launch app maximize window and set timeout
Test Teardown    Close browser and take screenshot

*** Variables ***
${mobno}    1234567890


*** Test Cases ***
TC01_Test Login page is displayed
    [Tags]    Smoke
    Given user is on landing page
    When user click on login link 
    Then login page is displayed
    
    

TC02_Test Login with mob no
    [Tags]    Regression
    Given user is on landing page
    When user click on login link 
    When login page is displayed
    When user enters mob no    ${mobno}
    


TC03_Login with multiple invalid mob nos
    [Tags]    Regression
    [Template]  Test Login with invalid mob no
    # start  eat  left
    1234567
    11@@@1111
    aasdd22222
    123__123
    
    

   
    
    
       
    
    
    
