//
//  MembersViewController.swift
//  Waves_iOS
//
//  Created by Rostyslav on 02.08.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit
import Alamofire

class MembersViewController: UIViewController {
    
    var waveNumber = Int()
    var wave = UIImage()
    var widthOfWave: CGFloat!
    var targetOfSaving = Int()
    var usersPhones = [String]()
    
    @IBOutlet weak var membersTableView: UITableView!
    @IBOutlet weak var numberOfWaveLabel: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var targetOfSavingLabel: UILabel!
    @IBOutlet weak var viewForWave: UIView!
    @IBOutlet weak var waveImage: UIImageView!
    @IBOutlet weak var numberOfMembersLabel: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!

    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWave()
        setLabels()
        
        sendRequest { (users) in
            for user in users {
                let userData = user as! NSDictionary
                self.usersPhones.append(userData["phone"]! as! String)
            }
            
            DispatchQueue.main.async {
                self.membersTableView.reloadData()
            }
        }
    }
    
    func setLabels() {
        
        numberOfWaveLabel.text = "Волна № \(waveNumber)"
        
        if targetOfSaving == User.shared.waves[waveNumber - 1] {
            targetOfSavingLabel.text = "Цель :  \(targetOfSaving) участников (достигнута)"
            
        } else {
            targetOfSavingLabel.text = "Цель :  \(targetOfSaving) участников"
        }
    }
    
    func setWave() {
        waveImage.image = wave
        widthConstraint.constant = widthOfWave
        numberOfMembersLabel.text = String(User.shared.waves[waveNumber - 1])
    }
    
    func sendRequest(com: @escaping (NSArray) -> ()) {
        
        let header: HTTPHeaders = ["Authorization": User.shared.token]
        let parameter: Parameters = ["n_wave": waveNumber]
        Alamofire.request(BASIS_URL + "/api/v1/getSingleWaveUser", method: .get, parameters: parameter, headers: header).responseJSON { response in
            
            let json = response.result.value
            let users = json as! NSArray
            com(users)
        }
    }
}

extension MembersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersPhones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = Bundle.main.loadNibNamed("MemberTableViewCell", owner: self, options: nil)?.first as! MemberTableViewCell
            cell.phoneNumberLabel.text = usersPhones[indexPath.row]
        
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let heightOfCell: CGFloat = 60
        
        return heightOfCell
    }
}

