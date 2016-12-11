//
//  AppState.swift
//  Goji
//
//  Created by Naelin Aquino on 12/9/16.
//  Copyright © 2016 Anae. All rights reserved.
//

import Foundation

class AppState: NSObject {
    
    static let sharedInstance = AppState()

    var signedIn = false
    var displayName: String?
    var photoURL: URL?
}
