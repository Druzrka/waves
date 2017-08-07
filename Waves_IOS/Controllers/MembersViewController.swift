//
//  MembersViewController.swift
//  Waves_iOS
//
//  Created by Rostyslav on 02.08.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit

class MembersViewController: UIViewController {
    
    var waveNumber = Int()
    
    @IBOutlet weak var membersCell: UITableView!

    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
