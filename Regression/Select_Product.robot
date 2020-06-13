*** Settings ***
Library    SeleniumLibrary    
Library    Collections  
Library    String  
Library    ../Python_Utility/Compare_values.py        
Resource    ../Resource/Myntra_Resource.robot
Test Setup    Launch app maximize window and set timeout




*** Variables ***

*** Keywords ***
get price
    [Arguments]    ${name}
    ${price}=    Get WebElement    xpath=(//h3[.='${name}'])[1]/../div/span
    ${p}=    Get Text    ${price} 
    Log To Console    ${p}
    Click Element    ${price}        
    Exit For Loop


*** Test Cases ***
TC01_Select HRX tshirt with discounted price 719
    Log To Console    Get Title    
    ${searchbox}=    Read element    LoginPage.Searchbox_xpath
    Press Key    xpath=${searchbox}    Tshirts
    Press Keys    None    ENTER
    @{brandname}=    Get WebElements    xpath=//div[@class='product-productMetaInfo']/h3   
    ${len}=    Get Length    ${brandname}
    
    :FOR    ${i}    IN RANGE    0    ${len}
    \    ${brand}=    Get From List     ${brandname}    ${i}
    \    ${name}=    Get Text    ${brand}
    \    Log To Console    ${name}
    \    Run Keyword If    '${name}'=='HRX by Hrithik Roshan'    get price    ${name}  
      
#    to switch to newly opned tab
    @{tabs}=    Get Window Handles    
    :FOR    ${tab}    IN    @{tabs}
    \    Log To Console    ${tab}
    \    Select Window    ${tab}
    \    ${url}=    Get Location
    \    Log To Console    ${url}        
        

    ${prce}=    Get WebElement    xpath=//span[@class='pdp-price']/strong
    ${p}=    Get Text    ${prce}
    ${pc}=    Get Substring    ${p}   4 
    ${size}=    Get WebElement    xpath=(//p[@class='size-buttons-unified-size'])[2]
    Click Element    ${size}
    ${AddToBag}=    Get WebElement    xpath=//div[.='ADD TO BAG']
    Click Element    ${AddToBag}
    ${GoToBag}=    Get WebElement    xpath=//a[.='GO TO BAG'] 
    Click Link    ${GoToBag}   
    @{BagItems}=    Get WebElements    xpath=//div[@id='cartItemsList']/div/div
    ${items}=    Get Length    ${BagItems}
    Log To Console    Items_in_Bag_${items}
    ${brandn}=    Get WebElement    xpath=//div[@class='itemContainer-base-brand']
    ${bname}=    Get Text    ${brandn}
    Should Be Equal    ${bname}    ${name}    
    ${priceinbag}=    Get WebElement    xpath=//div[@class='itemContainer-base-brand']/../../div[4]/div[1]/div
    ${price}=    Get Text    ${priceinbag}
    Log To Console    ${pc}    
    
    Should Be Equal    ${price}    ${pc}                
           

TC02_Select Shoes from men dropdown and valide brand name and price
    Mouse Over    xpath=//a[.='Men']
    Click Link    xpath=//a[.='Sneakers']  
    ${mybrand}=    Set Variable    DC   
    @{bnames}=    Get WebElements    xpath=//ul[@class='brand-list']/li/label
#    :FOR    ${brand}    IN    @{bnames}
#    \    ${bn}=    Get Text    ${brand}
#    \    Log To Console    ${bn}   
    Set Selenium Speed    2 second
     
    Wait Until Page Contains Element    xpath=(//label[@class='vertical-filters-label common-customCheckbox'])[1]
    Element Should Be Enabled    xpath=(//label[@class='vertical-filters-label common-customCheckbox'])[1]   
    sleep    1s
    Click Element    xpath=(//label[@class='vertical-filters-label common-customCheckbox'])[1]
    Click Element    xpath=(//label[@class='common-customCheckbox vertical-filters-label']) 
#    Execute Javascript    window.scrollTo(0,4000) 
#    Press Keys    None    DOWN
#    Element Should Be Enabled    xpath=//input[@value='20.0 TO 100.0']
#    Click Element    xpath=//input[@value='20.0 TO 100.0']    
    
#    Scroll Element Into View    xpath=//input[@value='10.0 TO 100.0']    
#    Click Element    xpath=//input[@value='10.0 TO 100.0']      
        
#    ===========verify that brand name is Puma=====================

    Set Selenium Speed    0 seconds
    @{bnames_puma}=    Get WebElements    xpath=//h3[@class='product-brand']
    :FOR    ${b_puma}    IN    @{bnames_puma} 
    \    ${n}=    Get Text    ${b_puma}
    \    Log To Console    ${n} 
    \    Should Be Equal    ${n}    Puma              


TC03_Check the sorting functionality low to high
    Mouse Over    xpath=//a[.='Men']
    Click Link    xpath=//a[.='Sneakers']    
    @{bnames}=    Get WebElements    xpath=//ul[@class='brand-list']/li/label      
    Set Selenium Speed    1 second
    Wait Until Page Contains Element    xpath=(//label[@class='vertical-filters-label common-customCheckbox'])[1]
    Element Should Be Enabled    xpath=(//label[@class='vertical-filters-label common-customCheckbox'])[1]   
  
    Click Element    xpath=(//label[@class='vertical-filters-label common-customCheckbox'])[1]
    Click Element    xpath=(//label[@class='common-customCheckbox vertical-filters-label'])
    Mouse Over    xpath=//div[@class='sort-sortBy'] 
    Click Element    xpath=//label[@class='sort-label ' and text()='Price: Low to High']    
    
    Set Selenium Speed    0 second
    @{price_ele}=    Get WebElements    xpath=(//span[@class='product-discountedPrice'])
    :FOR    ${price}    IN    @{price_ele}
    \    ${p}=    Get Text    ${price}
    \    ${p_val}=    Get Substring    ${p}    4
    \    Log To Console    ${p_val}            
       
    ${len}=    Get Length    ${price_ele}
    
    :FOR    ${i}    IN RANGE    0    ${len-1}
    \    ${e1}=    Get From List    ${price_ele}    ${i}
    \    ${e2}=    Get From List    ${price_ele}    ${i+1}
    \    ${p1}=    Get Text    ${e1}
    \    ${p1}=    Get Substring    ${p1}    4    
    \    ${p2}=    Get Text    ${e2}
    \    ${p2}=    Get Substring    ${p2}    4
    \    ${p1}=    Convert To Integer    ${p1}    
    \    ${p2}=    Convert To Integer    ${p2}   
    \    
    \    compare price    ${p1}    <=    ${p2}
    \    
    

TC04_Testing sort method
    ${l1}=    Create List    1    2    3    4    5
    ${l2}=    Create List    1    2    3    4    5    
    Mysorting    self    ${l1}    ${l2}
        
