*** Settings ***
Library    SeleniumLibrary    
Library    Collections    
Resource    Myntra_Resource.robot
Test Setup    Launch app maximize window and set timeout

*** Variables ***


*** Test Cases ***
TC01_Login application with valid mob no
    ${profile_xpath}=    Read element    LoginPage.profile_xpath
    #Click Element    xpath= ${profile_xpath} 
    Page Should Contain Element    xpath=${profile_xpath}    
    Mouse Over    xpath= ${profile_xpath} 
    ${login_xpath}=    Read element    LoginPage.Login/SignUp_xpath
    Page Should Contain Link    ${login_xpath}
    Click Link    xpath=${login_xpath}    
    Go Back
    Sleep    10s 
    
    

TC02_Fetch the brand name with price of T Shirts
    ${searchbox}=    Read element    LoginPage.Searchbox_xpath
    Press Key    xpath=${searchbox}    Tshirts
    Press Keys    None    ENTER
    
    @{brandname}=    Get WebElements    xpath=//div[@class='product-productMetaInfo']/h3
    @{brandDesc}=    Get WebElements    xpath=//div[@class='product-productMetaInfo']/h4[1]
    @{pricelist}=    Get WebElements    xpath=//div[@class='product-productMetaInfo']/div[@class='product-price']/span[1] | //div[@class='product-productMetaInfo']/div[@class='product-price']/span[1]/span[@class='product-discountedPrice']
    ${totalBrands}=    Get Length    ${brandname}
    Log To Console    ${totalBrands}  
    Log To Console    ${totalBrands+1}    
   # ${tbs}=    Convert To Integer    ${totalBrands}+1 
    :FOR    ${i}    IN RANGE    0    ${totalBrands}
    \    ${brand}=    Get From List     ${brandname}    ${i}
    \    ${name}=    Get Text    ${brand}
    \    ${desc}=    Get From List    ${brandDesc}    ${i}
    \    ${ds}=    Get Text    ${desc}
    \    ${price}=    Get From List    ${pricelist}    ${i}
    \    ${pc}=    Get Text    ${price}
    

    \    Log To Console    ${name} price is ${pc} with desc ${ds}        
    
#        ${n}    Get Text    ${name}
#        Log To Console    ${n}    
        
TC03_Select RedTape tshirt with discounted price 719
    Log To Console    Get Title    
    ${searchbox}=    Read element    LoginPage.Searchbox_xpath
    Press Key    xpath=${searchbox}    Tshirts
    Press Keys    None    ENTER
    @{brandname}=    Get WebElements    xpath=//div[@class='product-productMetaInfo']/h3   
    ${totalBrands}=    Get Length    ${brandname}
    :FOR    ${i}    IN RANGE    0    ${totalBrands}
    \    ${brand}=    Get From List     ${brandname}    ${i}
    \    ${name}=    Get Text    ${brand}
    \    Log To Console    ${name} 
    \    Run Keyword If    "${name}"=="WROGN"    check price
    \       
    


*** Keywords ***
 check price 
    ${Price}=    Get WebElement    xpath=//div[@class='product-productMetaInfo']/div/span   
    ${pricevalue}=    Get Text    ${Price}
    Log To Console    ${pricevalue} 
    Exit For Loop








