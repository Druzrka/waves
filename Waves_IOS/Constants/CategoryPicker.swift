//
//  CategoryModelPicker.swift
//  Waves_iOS
//
//  Created by Захар on 18.07.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit

class CategoryPicker: UIPickerView {
    
    var categories = [String]()
    var goals = [[String]]()
    
    func getCategoriesAndGoalsFromDictionary() {
        
        for (key, value) in CATEGORIES_DICTONARY {
            categories.append(key)
            goals.append(value)
        }
    }
}


extension CategoryPicker: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        getCategoriesAndGoalsFromDictionary()
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
}

extension CategoryPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
}








