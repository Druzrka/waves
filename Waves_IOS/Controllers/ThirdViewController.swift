//
//  ThirdViewController.swift
//  Waves_iOS
//
//  Created by Захар on 24.07.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit
import Alamofire

class ThirdViewController: UIViewController {
    
    var currentTask = 0
    var data: NSDictionary!
    var id = [String]()
    
    
    let lastTask = 6
    let firstTask = 0
    
    let OK = 200
    
    @IBOutlet weak var taskCounter: UILabel!
    @IBOutlet weak var textOfTask: UITextView!
    
    @IBAction func previousTaskButton(_ sender: UIButton) {
        if currentTask != firstTask {
            currentTask -= 1
            setCurrentTaskToLabel(numberOfTask: currentTask)
            setCurrentTaskToServer()
        }
    }
    
    @IBAction func nextTaskButton(_ sender: UIButton) {
        if currentTask != lastTask {
            currentTask += 1
            setCurrentTaskToLabel(numberOfTask: currentTask)
            setCurrentTaskToServer()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllTasksWithIDFromServer()
        getCurrentTaskFromServer()
    }
    
    func getCurrentTaskFromServer() {
        
        let headers: HTTPHeaders = ["Authorization": User.shared.token]
        
        Alamofire.request(BASIS_URL + "/api/v1/getUserCurrentTask", method: .get, headers: headers).responseJSON { response in
  
            if let json = response.result.value {
                
                if let currentTitleAndText = json as? NSDictionary {
                    let numberOfTask = String(describing: currentTitleAndText["title"]!).characters.last!
                    self.currentTask = Int(String(numberOfTask))! - 1
                }
                
                self.setCurrentTaskToLabel(numberOfTask: self.currentTask)
            }
        }
    }
    
    func setCurrentTaskToServer() {
        
        let parameter = ["task_id": id[currentTask]]
        let header: HTTPHeaders = ["Authorization": User.shared.token]
        
        Alamofire.request(BASIS_URL + "/api/v1/setUserCurrentTask", method: .patch, parameters: parameter, headers: header).responseJSON { response in
            
            if response.response?.statusCode == self.OK {
                print("Number of task was set")
                
            } else {
                print("Number of task wasn't set")
            }
        }
    }
    
    func getAllTasksWithIDFromServer() {
        Alamofire.request(BASIS_URL + "/api/v1/getTaskList", method: .get).responseJSON { response in
            
            if let json = response.result.value {
                let response = json as! NSArray
                
                for index in 0...response.count - 1 {
                    
                    self.data = response.object(at: index) as! NSDictionary
                    self.id.append(self.data["_id"] as! String)
                }
            }
        }
    }
    
    func setCurrentTaskToLabel(numberOfTask: Int) {
        
        taskCounter.text = String(numberOfTask + 1)
        textOfTask.text = TASKS[numberOfTask]
    }
}






