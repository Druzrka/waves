//
//  PersonalAreaViewController.swift
//  Waves_iOS
//
//  Created by Захар on 03.08.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit
import Alamofire

class PersonalAreaViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var passwordField: DesignTextField!
    @IBOutlet weak var retryPasswordField: DesignTextField!
    @IBOutlet weak var emailField: DesignTextField!
    
    @IBAction func savePasswordButton(_ sender: UIButton) {
        
        if fieldsAreEmpty(){
            statusLabel.text = "Вызаполинили не все поля"
        
        } else if !passwordsAreIdentical() {
            statusLabel.text = "Пароли не совпадают"
            
        } else if !isValidEmailAddress() {
            statusLabel.text = "Вы ввели некорректный почтовый адрес"
            
        } else {
            savePassword()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        User.shared.token = "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyIkX18iOnsic3RyaWN0TW9kZSI6dHJ1ZSwic2VsZWN0ZWQiOnt9LCJnZXR0ZXJzIjp7fSwiX2lkIjoiNTk4NDM5ZWJlMmMxNzg3Zjc0M2U1ZTM1Iiwid2FzUG9wdWxhdGVkIjpmYWxzZSwiYWN0aXZlUGF0aHMiOnsicGF0aHMiOnsicGhvbmUiOiJpbml0IiwicGFzc3dvcmQiOiJpbml0IiwiYmFsYW5jZSI6ImluaXQiLCJwYXltZW50IjoiaW5pdCIsInBheV9kYXRlIjoiaW5pdCIsImJvbnVzX2ZhY3RvciI6ImluaXQiLCJ1cHBlcl91c2VyX3Bob25lIjoiaW5pdCIsInVwcGVyX3VzZXJfaWQiOiJpbml0IiwicmVmZXJhbHMiOiJpbml0IiwidzEiOiJpbml0IiwidzIiOiJpbml0IiwidzMiOiJpbml0IiwidzQiOiJpbml0IiwidzUiOiJpbml0IiwidzYiOiJpbml0IiwidzciOiJpbml0IiwidzgiOiJpbml0IiwidzkiOiJpbml0IiwicDEiOiJpbml0IiwicDIiOiJpbml0IiwicDMiOiJpbml0IiwicDQiOiJpbml0IiwicDUiOiJpbml0IiwicDYiOiJpbml0IiwicDciOiJpbml0IiwicDgiOiJpbml0IiwicDkiOiJpbml0IiwiY3VycmVudF90YXNrIjoiaW5pdCIsIl9fdiI6ImluaXQiLCJwaW4iOiJpbml0IiwiX2lkIjoiaW5pdCJ9LCJzdGF0ZXMiOnsiaWdub3JlIjp7fSwiZGVmYXVsdCI6e30sImluaXQiOnsiX192Ijp0cnVlLCJwYXNzd29yZCI6dHJ1ZSwiYmFsYW5jZSI6dHJ1ZSwicGF5bWVudCI6dHJ1ZSwicGF5X2RhdGUiOnRydWUsImJvbnVzX2ZhY3RvciI6dHJ1ZSwidXBwZXJfdXNlcl9waG9uZSI6dHJ1ZSwidXBwZXJfdXNlcl9pZCI6dHJ1ZSwicmVmZXJhbHMiOnRydWUsIncxIjp0cnVlLCJ3MiI6dHJ1ZSwidzMiOnRydWUsInc0Ijp0cnVlLCJ3NSI6dHJ1ZSwidzYiOnRydWUsInc3Ijp0cnVlLCJ3OCI6dHJ1ZSwidzkiOnRydWUsInAxIjp0cnVlLCJwMiI6dHJ1ZSwicDMiOnRydWUsInA0Ijp0cnVlLCJwNSI6dHJ1ZSwicDYiOnRydWUsInA3Ijp0cnVlLCJwOCI6dHJ1ZSwicDkiOnRydWUsImN1cnJlbnRfdGFzayI6dHJ1ZSwicGluIjp0cnVlLCJwaG9uZSI6dHJ1ZSwiX2lkIjp0cnVlfSwibW9kaWZ5Ijp7fSwicmVxdWlyZSI6e319LCJzdGF0ZU5hbWVzIjpbInJlcXVpcmUiLCJtb2RpZnkiLCJpbml0IiwiZGVmYXVsdCIsImlnbm9yZSJdfSwicGF0aHNUb1Njb3BlcyI6e30sImVtaXR0ZXIiOnsiZG9tYWluIjpudWxsLCJfZXZlbnRzIjp7fSwiX2V2ZW50c0NvdW50IjowLCJfbWF4TGlzdGVuZXJzIjowfX0sImlzTmV3IjpmYWxzZSwiX2RvYyI6eyJwYXNzd29yZCI6bnVsbCwiYmFsYW5jZSI6MCwicGF5bWVudCI6MCwicGF5X2RhdGUiOm51bGwsImJvbnVzX2ZhY3RvciI6MC4yNSwidXBwZXJfdXNlcl9waG9uZSI6bnVsbCwidXBwZXJfdXNlcl9pZCI6bnVsbCwicmVmZXJhbHMiOltdLCJ3MSI6MCwidzIiOjAsInczIjowLCJ3NCI6MCwidzUiOjAsInc2IjowLCJ3NyI6MCwidzgiOjAsInc5IjowLCJwMSI6MCwicDIiOjAsInAzIjowLCJwNCI6MCwicDUiOjAsInA2IjowLCJwNyI6MCwicDgiOjAsInA5IjowLCJjdXJyZW50X3Rhc2siOm51bGwsIl9fdiI6MCwicGluIjoiJDJhJDEwJGx0L2tBNFB4TU9PZE1CZlcySUVMYS5mLnoxdWp0TWhSNEpFbXZMdmxtaFkuQm5FY1NtNGRTIiwicGhvbmUiOiIrMzgwOTUxMjE2NDIyIiwiX2lkIjoiNTk4NDM5ZWJlMmMxNzg3Zjc0M2U1ZTM1In0sIiRpbml0Ijp0cnVlLCJpYXQiOjE1MDE4Mzc4MDcsImV4cCI6MTUwMTg0Nzg4N30.zUQz8SekEaOjnwEo9nTkT9lejKJBRDc_GoCM7DGW_wg"
    }
    
    func passwordsAreIdentical() -> Bool {
        let password = passwordField.text
        let retryPassword = retryPasswordField.text
        
        if password == retryPassword {
            return true
        }
        return false
    }
    
    func isValidEmailAddress() -> Bool {
        
        let emailAddressString = emailField.text
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString! as NSString
            let results = regex.matches(in: emailAddressString!, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
    func fieldsAreEmpty() -> Bool {
        return (passwordField.text?.isEmpty)! || (retryPasswordField.text?.isEmpty)! || (emailField.text?.isEmpty)!
    }
    
    func savePassword() {
        
        let password = passwordField.text
        
        sendRequest(password: password!) { (statusCode) in
            let OK = 200
            
            if statusCode == OK {
                self.statusLabel.text = "Пароль сохранен"
                self.dismiss(animated: true, completion: nil)
                
            } else {
                self.statusLabel.text = "Пароль не сохранен"
            }
        }
    }
    
    
    func sendRequest(password: String, com: @escaping (Int) -> ()) {
        
        let header: HTTPHeaders = ["Authorization": User.shared.token]
        let parameter: Parameters = ["password": password]
        Alamofire.request(BASIS_URL + "/api/v1/setUserPassword", method: .patch, parameters: parameter, headers: header).responseJSON { response in
            
            com((response.response?.statusCode)!)
        }
    }
}




