//
//  MenuViewController.swift
//  Waves_iOS
//
//  Created by Захар on 21.07.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit

struct cellData {
    
    let cell: Int!
    let text: String!
}

class MenuViewController: UIViewController {
    
    var arrayOfCellData = [cellData]()
    
    let menuItems = ["Волны", "Задачи", "Приглашения", "Редактирование мечты", "Звук", "PUSH уведомления", "Вывод средств через WebView", "Оплата регистрационного взноса", "Вывод средств на карту"]
    
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        setDataForCells()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func handleSwipe(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.left:
            dismiss(animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    func setDataForCells() {
        for title in menuItems {
            
            if title == "Звук" || title == "PUSH уведомления" {
                arrayOfCellData.append(cellData(cell: 2, text: title))
                
            } else {
                arrayOfCellData.append(cellData(cell: 1, text: title))
            }
        }
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrayOfCellData[indexPath.row].cell == 1 {
            
            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
            
            cell.titleLabel.text = arrayOfCellData[indexPath.row].text
            
            return cell
            
        } else {
            let cell = Bundle.main.loadNibNamed("TableViewCellWithSwitch", owner: self, options: nil)?.first as! TableViewCellWithSwitch
            
            cell.titleLabel.text = arrayOfCellData[indexPath.row].text
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightOfCell: CGFloat = 40
        
        return heightOfCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            performSegue(withIdentifier: "From Main Screen To Choose Goal Screen", sender: self)
        }
    }
}
