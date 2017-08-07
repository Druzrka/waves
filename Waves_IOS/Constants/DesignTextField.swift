//
//  DesignTextField.swift
//  Waves_iOS
//
//  Created by Захар on 03.08.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit

@IBDesignable
class DesignTextField: UITextField {
    
    @IBInspectable var placeHolderFontSize: CGFloat = 15 {
        didSet {
            changePlaceholderColor()
        }
    }
    
    func changePlaceholderColor() {
        attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSForegroundColorAttributeName : tintColor, NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: placeHolderFontSize)!])
    }
}
