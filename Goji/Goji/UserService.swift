//
//  UserService.swift
//  Goji
//
//  Created by Naelin Aquino on 12/11/16.
//  Copyright © 2016 Anae. All rights reserved.
//

import Foundation

class UserService {
    
    static func retrieveCreatedCardIds(userId: String) -> [String] {
        return UserDao.retrieveCreatedCardIds(userId: userId)
    }
}
