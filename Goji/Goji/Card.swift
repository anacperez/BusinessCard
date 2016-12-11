//
//  Card.swift
//  Goji
//
//  Created by Naelin Aquino on 11/14/16.
//  Copyright © 2016 Anae. All rights reserved.
//

class Card {
    var title: String
    var first: String?
    var last: String?
    var company: String?
    var phone: String?
    var email: String?
    var address: String?
    var site: String?
    var job: String?
    var other: String?
    
    init(title: String, first: String?, last: String?, company: String?, phone: String?,
         email: String?, address: String?, site: String?, job: String?,
         other: String?) {
        self.title = title
        self.first = first
        self.last = last
        self.company = company
        self.phone = phone
        self.email = email
        self.address = address
        self.site = site
        self.job = job
        self.other = other
    }
    
    
}
