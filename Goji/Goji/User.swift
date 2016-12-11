//
//  User.swift
//  Goji
//
//  Created by Naelin Aquino on 12/11/16.
//  Copyright © 2016 Anae. All rights reserved.
//

class User {
    var userId: String
    var createdCards: [String]
    var connections: [String]

    
    init(userId: String, createdCards: [String], connections: [String]) {
        self.userId = userId
        self.createdCards = createdCards
        self.connections = connections
    }
    
}
