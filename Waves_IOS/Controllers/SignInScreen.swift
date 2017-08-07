//
//  SignInScreen.swift
//  Waves_iOS
//
//  Created by Захар on 17.07.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit
import AKMaskField
import IQKeyboardManagerSwift
import Alamofire

class SignInScreen: UIViewController {

    var countries =  [String]()
    var selectedCountry = String()
    var timer = Timer()
    var time = 0
    var phoneNumberOfUser = ""
    var statusCode = Int()
    
    let BASIS_URL = "http://82.146.58.19:3000"
    let USER_REGISTERED = 200
    let MESSAGE_SENT = 200
    let CODE_IS_CORRECT = 201
    let USER_UNREGISTERED = 400
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var phoneNumberField: AKMaskField!
    @IBOutlet weak var choiseOfCountry: UITextField!
    @IBOutlet weak var OkSendMessageButton: UIButton!
    @IBOutlet weak var fieldForCode: UITextField!
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func verify(_ sender: UIButton) {
        let pinCode = fieldForCode.text!
        
        Alamofire.request(BASIS_URL + "/api/v1/user", method: .patch, parameters: ["phone": phoneNumberOfUser, "pin": pinCode]).responseJSON { (response) in
            if response.response?.statusCode == self.CODE_IS_CORRECT {
                self.statusLabel.text = "Номер телефона подтвержден"
                
            } else {
                self.statusLabel.text = "Вы ввели не правильный код"
            }
        }
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        
        if phoneNumberField.maskStatus == .clear {
            showAlert(message: "Вы не ввели номер телефона!")
            
        } else if phoneNumberField.maskStatus == .incomplete {
            showAlert(message: "Вы ввели номер телефона не полностью!")
            
        } else {
            
            getPhoneNumberFromField()
            
            Alamofire.request(BASIS_URL + "/api/v1/getUserRegister", method: .get, parameters: ["phone": phoneNumberOfUser]).responseJSON { (response) in
                
                if response.response?.statusCode == self.USER_UNREGISTERED {
                    
                    Alamofire.request(self.BASIS_URL + "/api/v1/user", method: .post, parameters: ["phone": self.phoneNumberOfUser]).responseJSON { (response) in
                        
                        if response.response?.statusCode == self.MESSAGE_SENT {
                            self.statusLabel.text = "Сообщение отправлено"
                        }
                    }
                    
                } else {
                    self.statusLabel.text = "Этот телефон уже зарегестрирован"
                }
            }
            startTimer()
        }
    }
    
    func getPhoneNumberFromField() {
        phoneNumberOfUser = phoneNumberField.text!.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range:nil)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setArrayOfCountries()
        
        createPickerView()
        
        createToolBar(textField: choiseOfCountry)
        createToolBar(textField: phoneNumberField)
        createToolBar(textField: fieldForCode)
    }
    
    func createPickerView() {
        
        let currencyPicker = UIPickerView()
        currencyPicker.delegate = self as! UIPickerViewDelegate
        
        choiseOfCountry.inputView = currencyPicker
        currencyPicker.backgroundColor = .white
    }
    
    func createToolBar(textField: UITextField) {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(RegistrationViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setCountryCodeToField() {
        
        phoneNumberField.maskExpression = "\(String(describing: countriesCodes[selectedCountry]!)) ({ddd}) {ddd}-{dd}-{dd}"
        phoneNumberField.maskTemplate = "\(String(describing: countriesCodes[selectedCountry]!)) (___) ___-__-__"
    }
    
    //    func sendRequest(method: HTTPMethod) {
    //
    //        var url = BASIS_URL
    //
    //        switch method {
    //
    //        case .get:
    //            url += "/api/v1/getUserRegister"
    //
    //        default:
    //            url += "/api/v1/user"
    //        }
    //
    //        Alamofire.request(url, method: method, parameters: ["phone": phoneNumberOfUser]).responseJSON { (response) in
    //
    //            self.statusCode = (response.response?.statusCode)!
    //        }
    //    }
    
    func showAlert(message: String) {
        let ALERT = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ACTION = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        ALERT.addAction(ACTION)
        present(ALERT, animated: true, completion: nil)
    }
    
    func setArrayOfCountries() {
        for key in countriesCodes.keys {
            countries.append(key)
        }
    }
    
    func startTimer() {
        time = 30
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RegistrationViewController.count), userInfo: nil, repeats: true)
    }
    
    func count() {
        if time == 0 {
            timerView.isHidden = true
            
        } else {
            time -= 1
            timerLabel.text = "Повторная отправка SMS через \(time)сек."
            timerView.isHidden = false
        }
    }
}

extension RegistrationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = countries[row]
        choiseOfCountry.text = countries[row]
        setCountryCodeToField()
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
