//
//  SecondViewController.swift
//  Waves_iOS
//
//  Created by Захар on 24.07.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var sizeOfWave = 0
    var numberOfBoreders = 4
    var startBorders = [1, 0, 0, 0, 0]
    var endBorders = [0, 0, 0, 0, 0]
    var sumNumbers = [5,25,125,625,3125,15625,78125,390625]
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var scrollViewForWaves: UIScrollView!
    @IBOutlet weak var viewForFirstWave: UIView!
    @IBOutlet weak var viewForSecondWave: UIView!
    @IBOutlet weak var viewForThirdWave: UIView!
    @IBOutlet weak var viewForFourthWave: UIView!
    @IBOutlet weak var viewForFifthWave: UIView!
    @IBOutlet weak var viewForSixthWave: UIView!
    @IBOutlet weak var viewForSeventhWave: UIView!
    @IBOutlet weak var viewForEighthWave: UIView!
    @IBOutlet weak var viewForNinthWave: UIView!
    
    @IBOutlet weak var firstWave: UIImageView!
    @IBOutlet weak var secondWave: UIImageView!
    @IBOutlet weak var thirdWave: UIImageView!
    @IBOutlet weak var fourthWave: UIImageView!
    @IBOutlet weak var fifthWave: UIImageView!
    @IBOutlet weak var sixthWave: UIImageView!
    @IBOutlet weak var seventhWave: UIImageView!
    @IBOutlet weak var eighthWave: UIImageView!
    @IBOutlet weak var ninthWave: UIImageView!
    
    @IBOutlet weak var membersOfFistWave: UILabel!
    @IBOutlet weak var membersOfSecondWave: UILabel!
    @IBOutlet weak var membersOfThirdWave: UILabel!
    @IBOutlet weak var membersOfFourthWave: UILabel!
    @IBOutlet weak var membersOfFifthWave: UILabel!
    @IBOutlet weak var membersOfSixthWave: UILabel!
    @IBOutlet weak var membersOfSeventhWave: UILabel!
    @IBOutlet weak var membersOfEighthWave: UILabel!
    @IBOutlet weak var membersOfNinthWave: UILabel!
    
    @IBOutlet weak var widthConstraintFirstView: NSLayoutConstraint!
    @IBOutlet weak var widthConstraintSecondView: NSLayoutConstraint!
    @IBOutlet weak var widthConstraintThirdView: NSLayoutConstraint!
    @IBOutlet weak var widthConstraintFourthView: NSLayoutConstraint!
    @IBOutlet weak var widthConstraintFifthView: NSLayoutConstraint!
    @IBOutlet weak var widthConstraintSixthView: NSLayoutConstraint!
    @IBOutlet weak var widthConstraintSeventhView: NSLayoutConstraint!
    @IBOutlet weak var widthConstraintEighthView: NSLayoutConstraint!
    @IBOutlet weak var widthConstraintNinthView: NSLayoutConstraint!
    
    @IBAction func firstWaveButton(_ sender: UIButton) {
        performSegue(withIdentifier: "From First Wave Screen To Members Screen", sender: self)
    }
    
    @IBAction func secondWaveButton(_ sender: UIButton) {
        performSegue(withIdentifier: "From Second Wave Screen To Members Screen", sender: self)
    }
    
    @IBAction func thirdWaveButton(_ sender: UIButton) {
        performSegue(withIdentifier: "From Third Wave Screen To Members Screen", sender: self)
    }
    
    @IBAction func fourthWaveButton(_ sender: UIButton) {
        performSegue(withIdentifier: "From Fourth Wave Screen To Members Screen", sender: self)
    }
    
    @IBAction func fifthWaveButton(_ sender: UIButton) {
        performSegue(withIdentifier: "From Fifth Wave Screen To Members Screen", sender: self)
    }
    
    @IBAction func sixthWaveButton(_ sender: UIButton) {
        performSegue(withIdentifier: "From Sixth Wave Screen To Members Screen", sender: self)
    }
    
    @IBAction func seventhWaveButton(_ sender: UIButton) {
        performSegue(withIdentifier: "From Seventh Wave Screen To Members Screen", sender: self)
    }
    
    @IBAction func eighthWaveButton(_ sender: UIButton) {
        performSegue(withIdentifier: "From Eighth Wave Screen To Members Screen", sender: self)
    }
    
    @IBAction func ninthWaveButton(_ sender: UIButton) {
        performSegue(withIdentifier: "From Ninth Wave Screen To Members Screen", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        User.shared.waves[0] = 4
        User.shared.waves[1] = 15
        
        setMembersLabels()
        setSizeOfWaves()
        balanceLabel.text = String(User.shared.balance)
    }
    
    func setMembersLabels() {
        membersOfFistWave.text = String(User.shared.waves[0])
        membersOfSecondWave.text = String(User.shared.waves[1])
        membersOfThirdWave.text = String(User.shared.waves[2])
        membersOfFourthWave.text = String(User.shared.waves[3])
        membersOfFifthWave.text = String(User.shared.waves[4])
        membersOfSixthWave.text = String(User.shared.waves[5])
        membersOfSeventhWave.text = String(User.shared.waves[6])
        membersOfEighthWave.text = String(User.shared.waves[7])
        membersOfNinthWave.text = String(User.shared.waves[8])
    }
    
    func setSizeOfWaves() {
        
        setSizeOfFirstWave()
        
        countBorders(sumNumber: sumNumbers[0])
        setSizeOfWave(wave: secondWave, view: viewForSecondWave, constraint: widthConstraintSecondView, numberOfWave: 1)
        
        countBorders(sumNumber: sumNumbers[1])
        setSizeOfWave(wave: thirdWave, view: viewForThirdWave, constraint: widthConstraintThirdView, numberOfWave: 2)
        
        countBorders(sumNumber: sumNumbers[2])
        setSizeOfWave(wave: fourthWave, view: viewForFourthWave, constraint: widthConstraintFourthView, numberOfWave: 3)
        
        countBorders(sumNumber: sumNumbers[3])
        setSizeOfWave(wave: fifthWave, view: viewForFifthWave, constraint: widthConstraintFifthView, numberOfWave: 4)
        
        countBorders(sumNumber: sumNumbers[4])
        setSizeOfWave(wave: sixthWave, view: viewForSixthWave, constraint: widthConstraintSixthView, numberOfWave: 5)
        
        countBorders(sumNumber: sumNumbers[5])
        setSizeOfWave(wave: seventhWave, view: viewForSeventhWave, constraint: widthConstraintSeventhView, numberOfWave: 6)
        
        countBorders(sumNumber: sumNumbers[6])
        setSizeOfWave(wave: eighthWave, view: viewForEighthWave, constraint: widthConstraintEighthView, numberOfWave: 7)
        
        countBorders(sumNumber: sumNumbers[7])
        setSizeOfWave(wave: ninthWave, view: viewForNinthWave, constraint: widthConstraintNinthView, numberOfWave: 8)
    }
    
    func setSizeOfFirstWave() {
        sizeOfWave = User.shared.waves[0]
        
        switch sizeOfWave {
        case 1:
            resizeWave(wave: firstWave, view: viewForFirstWave, constraint: widthConstraintFirstView, sizeOfWave: 1)
        case 2:
            resizeWave(wave: firstWave, view: viewForFirstWave, constraint: widthConstraintFirstView, sizeOfWave: 2)
        case 3:
            resizeWave(wave: firstWave, view: viewForFirstWave, constraint: widthConstraintFirstView, sizeOfWave: 3)
        case 4:
            resizeWave(wave: firstWave, view: viewForFirstWave, constraint: widthConstraintFirstView, sizeOfWave: 4)
        case 5:
            resizeWave(wave: firstWave, view: viewForFirstWave, constraint: widthConstraintFirstView, sizeOfWave: 5)
        default:
            resizeWave(wave: firstWave, view: viewForFirstWave, constraint: widthConstraintFirstView, sizeOfWave: 1)
        }
    }
    
    func countBorders(sumNumber: Int) {
        
        var previousItem = startBorders[0]
        
        for index in 1...numberOfBoreders {
            endBorders[index - 1] = previousItem + sumNumber
            startBorders[index] = previousItem + sumNumber
            previousItem = startBorders[index]
        }
    }
    
    func setSizeOfWave(wave: UIImageView, view: UIView, constraint: NSLayoutConstraint,numberOfWave: Int) {
        
        sizeOfWave = User.shared.waves[numberOfWave]
        
        switch sizeOfWave {
        case startBorders.first!...endBorders.first!:
            resizeWave(wave: wave, view: view, constraint: constraint, sizeOfWave: 1)
            break
            
        case startBorders[1]...endBorders[1]:
            resizeWave(wave: wave, view: view, constraint: constraint, sizeOfWave: 2)
            break
            
        case startBorders[2]...endBorders[2]:
            resizeWave(wave: wave, view: view, constraint: constraint, sizeOfWave: 3)
            break
            
        case startBorders[3]...endBorders[3]:
            resizeWave(wave: wave, view: view, constraint: constraint, sizeOfWave: 4)
            break
           
        default:
            resizeWave(wave: wave, view: view, constraint: constraint, sizeOfWave: 5)
            break
        }
    }
    
    func resizeWave(wave: UIImageView, view: UIView, constraint: NSLayoutConstraint, sizeOfWave: Int) {
        
        switch sizeOfWave {
        case 1:
            wave.image = UIImage(named: "oneWave.png")
            view.frame.size.width = 90
            constraint.constant = 90
            view.layoutIfNeeded()
        case 2:
            wave.image = UIImage(named: "twoWaves.png")
            view.frame.size.width = 150
            constraint.constant = 150
            view.layoutIfNeeded()
        case 3:
            wave.image = UIImage(named: "threeWaves.png")
            view.frame.size.width = 200
            constraint.constant = 200
            view.layoutIfNeeded()
        case 4:
            wave.image = UIImage(named: "fourWaves.png")
            view.frame.size.width = 270
            constraint.constant = 270
            view.layoutIfNeeded()
        default:
            wave.image = UIImage(named: "oneWave.png")
            view.frame.size.width = 90
            constraint.constant = 90
            view.layoutIfNeeded()
        }
    }
}

extension SecondViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "From First Wave Screen To Members Screen" {
            if let destination = segue.destination as? MembersViewController {
                destination.waveNumber = 1
            }
        } else if segue.identifier == "From Second Wave Screen To Members Screen" {
            if let destination = segue.destination as? MembersViewController {
                destination.waveNumber = 2
            }
        } else if segue.identifier == "From Third Wave Screen To Members Screen" {
            if let destination = segue.destination as? MembersViewController {
                destination.waveNumber = 3
            }
        } else if segue.identifier == "From Fourth Wave Screen To Members Screen" {
            if let destination = segue.destination as? MembersViewController {
                destination.waveNumber = 4
            }
        } else if segue.identifier == "From Fifth Wave Screen To Members Screen" {
            if let destination = segue.destination as? MembersViewController {
                destination.waveNumber = 5
            }
        } else if segue.identifier == "From Sixth Wave Screen To Members Screen" {
            if let destination = segue.destination as? MembersViewController {
                destination.waveNumber = 6
            }
        } else if segue.identifier == "From Seventh Wave Screen To Members Screen" {
            if let destination = segue.destination as? MembersViewController {
                destination.waveNumber = 7
            }
        } else if segue.identifier == "From Eighth Wave Screen To Members Screen" {
            if let destination = segue.destination as? MembersViewController {
                destination.waveNumber = 8
            }
        } else if segue.identifier == "From Ninth Wave Screen To Members Screen" {
            if let destination = segue.destination as? MembersViewController {
                destination.waveNumber = 9
            }
        }
    }
}

