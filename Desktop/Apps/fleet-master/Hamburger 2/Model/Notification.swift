//
//  Group.swift
//  Hamburger 2
//
//  Created by Ryan Selden on 11/6/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import Foundation


struct Notification {
    let username: String?
    let photo_key: String?
    let person: Person?

    var mainText: String = ""
    var timeString: String = ""
    var platform: String = ""

    init? (mainText: String, username: String, timeString: String, photo_key: String, person: Person?, platform: String) {
        self.mainText = mainText
        self.username = username
        self.timeString = timeString
        self.photo_key = photo_key
        self.person = person
        self.platform = platform
    }
}

