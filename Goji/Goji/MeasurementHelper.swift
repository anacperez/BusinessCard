//
//  MeasurementHelper.swift
//  Goji
//
//  Created by Naelin Aquino on 12/9/16.
//  Copyright © 2016 Anae. All rights reserved.
//

import UIKit
import Firebase

class MeasurementHelper: NSObject {
    
    static func sendLoginEvent() {
        FIRAnalytics.logEvent(withName: kFIREventLogin, parameters: nil)
    }
    
    static func sendLogoutEvent() {
        FIRAnalytics.logEvent(withName: "logout", parameters: nil)
    }
    
    static func sendMessageEvent() {
        FIRAnalytics.logEvent(withName: "message", parameters: nil)
    }
}
