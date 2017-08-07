//
//  UsersAreementViewController.swift
//  Waves_iOS
//
//  Created by Захар on 07.07.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit

class UsersAreementViewController: UIViewController {
    
    @IBAction func dismissUsersAgreement(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImage.layer.cornerRadius = 5
        logoImage.clipsToBounds = true
    }
}
