//
//  FirstViewController.swift
//  Waves_iOS
//
//  Created by Захар on 24.07.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit
import Social
import MessageUI


class FirstViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    @IBAction func next(_ sender: UIButton) {
        PageViewController().next()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //поделиться реферальной ссылкой через What's up
    
    @IBAction func whatsUpShare(_ sender: Any) {
        let url = URL(string: "whatsapp://send?text=https://auto.ria.com")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    //поделиться реферальной ссылкой через Viber
    
    @IBAction func viberShare(_ sender: Any) {
        let url = URL(string: "viber://forward?text=https://auto.ria.com")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    //поделиться реферальной ссылкой в Фейсбуке
    
    @IBAction func facebookShare(_ sender: Any) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
            
            let fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            fbShare.setInitialText("https://auto.ria.com")
            self.present(fbShare, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Facebook", message: "Пожалуйста зарегистрируйтесь или войдите в Facebook", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //поделиться реферальной ссылкой через СМС
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func smsShare(_ sender: Any) {
        
        if MFMessageComposeViewController.canSendText()
        {
            let controller = MFMessageComposeViewController()
            controller.body = "https://auto.ria.com"
            controller.recipients = [""]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
        else
        {
            print("Попробуйте отправить СМС еще раз")
        }
    }
    
}
