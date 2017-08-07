//
//  MainScreenViewController.swift
//  Waves_iOS
//
//  Created by Захар on 21.07.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    
    @IBAction func menuButton(_ sender: UIButton) {
        performSegue(withIdentifier: "menuSegue", sender: self)
    }
    
    override func viewDidLoad() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func handleSwipe(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            performSegue(withIdentifier: "menuSegue", sender: self)
            break
        default:
            break
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? MenuViewController {
            if segue.identifier == "MenuSugue" {

                slideInTransitioningDelegate.direction = .left
            }
            controller.transitioningDelegate = slideInTransitioningDelegate
            controller.modalPresentationStyle = .custom
        }
    }
}
