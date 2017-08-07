
//
//  RegistrationViewController.swift
//  Waves_iOS
//
//  Created by Захар on 07.07.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit
import AKMaskField
import IQKeyboardManagerSwift
import Alamofire

class RegistrationViewController: UIViewController {
    
    var countries =  [String]()
    var selectedCountry = String()
    var timer = Timer()
    var time = 0
    var phoneNumberOfUser = ""
    var statusCode = Int()
    var action = ""
    
    let USER_REGISTERED = 200
    let MESSAGE_SENT = 200
    let CODE_IS_CORRECT = 201
    let USER_UNREGISTERED = 400
    
    @IBOutlet weak var actionLabel: UILabel!
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
                
                if let json = response.result.value {
                    let response = json as! NSDictionary
                    self.getAllDataFromJson(response: response)
                }
                
                self.performSegue(withIdentifier: "From Registration Screen To Success Reg Screen", sender: self)
                
            } else {
                self.statusLabel.text = "Вы ввели не правильный код"
            }
        }
    }
    
//  методу нид рефактор
    @IBAction func sendMessage(_ sender: UIButton) {
        
        if phoneNumberField.maskStatus == .clear {
            showAlert(message: "Вы не ввели номер телефона!")

        } else if phoneNumberField.maskStatus == .incomplete {
            showAlert(message: "Вы ввели номер телефона не полностью!")
            
        } else {
            
            getPhoneNumberWithoutSpacesAndSymbolsFromField()
            
            if action == "registration" {
            
                Alamofire.request(BASIS_URL + "/api/v1/getUserRegister", method: .get, parameters: ["phone": phoneNumberOfUser]).responseJSON { (response) in
                
                    if response.response?.statusCode == self.USER_UNREGISTERED {
                
                        Alamofire.request(BASIS_URL + "/api/v1/user", method: .post, parameters: ["phone": self.phoneNumberOfUser]).responseJSON { (response) in
                        
                            if response.response?.statusCode == self.MESSAGE_SENT {
                                self.OkSendMessageButton.isEnabled = false
                                self.statusLabel.text = "Сообщение отправлено"
                                self.startTimer()
                            }
                        }
                
                    } else {

                        self.statusLabel.text = "Этот телефон уже зарегестрирован"
                    }
                }
                
            } else {
                
                print("PHONE NUMBER OF USER: \(phoneNumberOfUser)")
                
                 Alamofire.request(BASIS_URL + "/api/v1/getUserRegister", method: .get, parameters: ["phone": phoneNumberOfUser]).responseJSON { (response) in
                    
                    if response.response?.statusCode == self.USER_REGISTERED {
                        
                        Alamofire.request(BASIS_URL + "/api/v1/user", method: .post, parameters: ["phone": self.phoneNumberOfUser]).responseJSON { (response) in
                            
                            if response.response?.statusCode == self.MESSAGE_SENT {
                                self.OkSendMessageButton.isEnabled = false
                                self.statusLabel.text = "Сообщение отправлено"
                                self.startTimer()
                                
                            } else {
                                self.statusLabel.text = "Ошыбка"
                            }
                        }
                        
                    } else {
                         self.statusLabel.text = "Этот телефон не зарегестрирован"
                    }
                }
            }
        }
    }
    
    func getPhoneNumberWithoutSpacesAndSymbolsFromField() {
        
        phoneNumberOfUser = phoneNumberField.text!
        
        let unnecessarySymbols = [" ", "-", "(", ")"]
        
        for symbol in unnecessarySymbols {
            phoneNumberOfUser = phoneNumberOfUser.replacingOccurrences(of: symbol, with: "", options: NSString.CompareOptions.literal, range:nil)
        }
        User.shared.phoneNumber =  phoneNumberOfUser
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setActionToLabel()
        setArrayOfCountries()
        countries.sort()
        
        createPickerView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "From Registration Screen To Success Reg Screen" {
            if let destination = segue.destination as? SuccessRegistrationViewController {
                if action == "registration"{
                    destination.action = "registration"
                } else {
                    destination.action = "sign in"
                }
            }
        }
    }
    
    func createPickerView() {
        
        let currencyPicker = UIPickerView()
        currencyPicker.delegate = self
        
        choiseOfCountry.inputView = currencyPicker
        currencyPicker.backgroundColor = .white
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setCountryCodeToField() {
        
        phoneNumberField.maskExpression = "\(String(describing: countriesCodes[selectedCountry]!)) ({ddd}) {ddd}-{dd}-{dd}"
        phoneNumberField.maskTemplate = "\(String(describing: countriesCodes[selectedCountry]!)) (___) ___-__-__"
    }
    
//    func sendRequest(method: HTTPMethod, com: (Int) -> ()) {
//        
//        sendRequest(method: .get) { statusCode in
//            
//        }
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
//            com(response.response!.statusCode)
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
            OkSendMessageButton.isEnabled = true
            
        } else {
            time -= 1
            timerLabel.text = "Повторная отправка SMS через \(time)сек."
            timerView.isHidden = false
        }
    }
    
    func setActionToLabel() {
        if action == "registration" {
            actionLabel.text = "Регистрация"
            
        } else {
            actionLabel.text = "Вход"
        }
    }
    
    func getAllDataFromJson(response: NSDictionary) {
        User.shared.token = response.object(forKey: "token") as! String
        User.shared.id = response.object(forKey: "_id") as! String
        User.shared.balance = response.object(forKey: "balance") as! Int
        setWaves(response: response)
    }
    
    func setWaves(response: NSDictionary) {
        var wave = "w1"
        var numberOfWave = 1
        
        for index in 0...8 {
            User.shared.waves[index] = response.object(forKey: wave) as! Int
            wave = "w" + String(numberOfWave)
            numberOfWave += 1
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

