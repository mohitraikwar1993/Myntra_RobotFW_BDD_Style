*** Settings ***
Library    ../Python_Utility/Compare_values.py    

*** Test Cases ***

TC04_Testing sort method
    ${l1}=    Create List    1    2    3    4    6
    ${l2}=    Create List    1    2    3    4    5    
    my_sorting    self    ${l1}    ${l2}