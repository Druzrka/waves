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




