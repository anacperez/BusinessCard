//
//  Constants.swift
//  Goji
//
//  Created by Naelin Aquino on 12/9/16.
//  Copyright © 2016 Anae. All rights reserved.
//

struct Constants {
    
    struct NotificationKeys {
        static let SignedIn = "onSignInCompleted"
    }
    
    struct Segues {
        static let SignInToMenu = "SignInToMenu"
        static let MenuToSignIn = "MenuToSignIn"
        static let MyCardCell = "MyCardCell"
        static let SaveCardDetail = "SaveCardDetail"
    }
    
    struct CardFields {
        static let address = "address"
        static let company = "company"
        static let email = "email"
        static let first = "first"
        static let last = "last"
        static let job = "job"
        static let other = "other"
        static let phone = "phone"
        static let site = "site"
        static let title = "title"

    }
    
    struct UserFields {
        static let created = "created"
        static let connections = "connections"
    }
    
    struct TableNames {
        static let USERS = "users"
        static let CARDS = "cards"
    }
}
