//
//  UserDao.swift
//  Goji
//
//  Created by Naelin Aquino on 12/11/16.
//  Copyright © 2016 Anae. All rights reserved.
//

import Foundation

import Firebase

class UserDao {
    
    static let ref = FIRDatabase.database().reference()
    
    static func retrieveCreatedCardIds(userId: String) -> [String] {
        var cardIds: [String]! = []
        
        let child = ref.child(Constants.TableNames.USERS).child(userId).child(Constants.UserFields.created)
        child.observe(.value) { (snap: FIRDataSnapshot) in
            cardIds = snap.value as! [String]
            print(snap.value as! [String])
        }
        
        return cardIds
    }
}
