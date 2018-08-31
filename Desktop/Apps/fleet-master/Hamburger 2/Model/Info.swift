//
//  ContactInfo.swift
//  Hamburger 2
//
//  Created by Joann Lin on 11/11/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import Foundation

enum InfoType: String {
    case phoneNumber = "Mobile"
    case email = "Email"
    case facebook = "Facebook"
    case snapchat = "Snapchat"
    case twitter = "Twitter"    //DC
    case instagram = "Instagram"
    case youtube = "Youtube"
    case pinterest = "Pinterest"    // DC
    case linkedin = "Linkedin"  //LT
    case custom = "Other"
}

struct Info {
    var infoType: InfoType
    var title: String
    var information: String
    var associatedProfiles: [Int] = []
    
    init (infoType: InfoType, title: String, information: String, associatedProfiles: [Int]) {
        self.infoType = infoType
        self.title = title
        self.information = information
        self.associatedProfiles = associatedProfiles
    }
}
