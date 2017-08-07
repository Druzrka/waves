//
//  ViewController.swift
//  Waves_iOS
//
//  Created by mac on 29.06.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func registration(_ sender: UIButton) {
        performSegue(withIdentifier: "From Start Screen To Registration", sender: self)
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        performSegue(withIdentifier: "From Start Screen To Sign In Screen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "From Start Screen To Registration" {
            if let destination = segue.destination as? RegistrationViewController {
                destination.action = "registration"
            }
        } else if segue.identifier == "From Start Screen To Sign In Screen" {
            if let destination = segue.destination as? RegistrationViewController {
                destination.action = "sing in"
            }
        }
    }
}
