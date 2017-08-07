//
//  ChooseGoalScreen.swift
//  Waves_iOS
//
//  Created by Захар on 18.07.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit
import Alamofire

class ChooseGoalScreen: UIViewController {
    
    var categoryPickerView = UIPickerView()
    var goalPickerView = UIPickerView()
    
    var categories = [String]()
    var targets = [String]()
    var selectedCategory = "Обучение"
    var selectedTarget = "Закончуть ВУЗ"
    
    let CHOICE_SELECTED = 200
    
    @IBOutlet weak var selectCategory: UITextField!
    @IBOutlet weak var selectGoal: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func selectButton(_ sender: UIButton) {
        
        let url = BASIS_URL + "/api/v1/setUserTarget"
        
        let parameters = [
            "target_name": selectedTarget,
            "target_cat": selectedCategory
        ]
        
        let headers: HTTPHeaders = ["Authorization": User.shared.token]
        
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { response in
            if response.response?.statusCode == self.CHOICE_SELECTED {
                self.statusLabel.text! = "Выбор сохранен"
                self.performSegue(withIdentifier: "From Choose Goal Screen To Main Screen", sender: self)
                
            } else {
                self.statusLabel.text! = response.error as! String
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        targets = CATEGORIES_DICTONARY[selectedCategory]!
        
        getCategoriesFromDictionary()
    
        createPickerView(textField: selectCategory, pickerView: categoryPickerView)
        createPickerView(textField: selectGoal, pickerView: goalPickerView)
    }
    
    func getCategoriesFromDictionary() {
        
        for key in CATEGORIES_DICTONARY.keys {
            categories.append(key)
        }
    }
    
    func createPickerView(textField: UITextField, pickerView: UIPickerView) {
        
        pickerView.delegate = self
        
        textField.inputView = pickerView
        pickerView.backgroundColor = .white
    }
    
    func createToolBar(textField: UITextField) {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(RegistrationViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
    }
}


extension ChooseGoalScreen: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == goalPickerView {
            return targets.count
        }
        
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == goalPickerView {
            return targets[row]
        }
        
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPickerView {
            selectedCategory = categories[row]
            selectCategory.text = selectedCategory
            targets = CATEGORIES_DICTONARY[selectedCategory]!
            
        } else {
            
            selectGoal.text = targets[row]
        }
    }
}




