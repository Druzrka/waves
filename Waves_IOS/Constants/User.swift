//
//  User.swift
//  Waves_iOS
//
//  Created by Захар on 19.07.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit

class User {
    
    var token: String!
    var phoneNumber: String!
    var id: String!
    var balance: Int!
    var waves = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    static let shared = User()
}
