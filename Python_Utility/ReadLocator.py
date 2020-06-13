import json
import jsonpath



def getLocatorValue(element_path):
        f=open("C:/Users/Beauty/eclipse-workspace/Myntra_RobotProject/JSON/Locators.json")
        s=f.read()
        js_body=json.loads(s)
        val=jsonpath.jsonpath(js_body,element_path)
        return val[0]
    
    
print(getLocatorValue('LoginPage.profile_xpath'))