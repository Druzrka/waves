//
//  AppDelegate.swift
//  Waves_iOS
//
//  Created by mac on 29.06.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Готово"
        return true
    }
}

