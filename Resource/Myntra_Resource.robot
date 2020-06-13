*** Settings ***
Library    SeleniumLibrary 
Library    ../Python_Utility/ReadLocator.py    
Library    ../Python_Utility/Compare_values.py

*** Variables ***
${url}    https://www.myntra.com/

*** Keywords ***
Launch app maximize window and set timeout
    [Documentation]    Launch the myntra application maximize the window and set timeout
    ${options}=    Evaluate    sys.modules['selenium.webdriver.chrome.options'].Options()
    Call Method    ${options}    add_argument    --disable-notifications
    ${driver}=    Create Webdriver    Chrome    options=${options}            
    Go To    ${url}
    Maximize Browser Window
    Set Browser Implicit Wait    8s
    Set Selenium Timeout    8s
    

Close browser and take screenshot
    [Documentation]    Close all the browser instances and take screenshot
    Capture Page Screenshot    ././screenshots/screenshot.png
    Close All Browsers
    

Read element
    [Arguments]    ${element_path}
    ${value}=    getLocatorValue     ${element_path}
    [Return]    ${value}
    

compare price
    [Arguments]    ${p1}    ${relation}    ${p2}
    Compare Val    self    ${p1}    ${relation}    ${p2}
    

