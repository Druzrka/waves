//
//  SuccessRegistration.swift
//  Waves_iOS
//
//  Created by Захар on 17.07.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit

class SuccessRegistrationViewController: UIViewController {
    
    var action = ""
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var celebrateImage: UIImageView!
    @IBOutlet weak var actionLabel: UILabel!
    
    @IBAction func okButton(_ sender: UIButton) {
        
        if action == "registration" {
            performSegue(withIdentifier: "From Success Reg To Choose Target Screen", sender: self)
            
        } else {
            performSegue(withIdentifier: "From Success Reg To Waves Screen", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(User.shared.token)
        
        if action == "sign in" {
            actionLabel.text! = "Вход"
            celebrateImage.image = #imageLiteral(resourceName: "successSignInImage")
        }
    }
}
