//
//  Group.swift
//  Hamburger 2
//
//  Created by Ryan Selden on 11/6/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import Foundation


struct Group {
    let name: String
    let username: String
    let bio: String
    let photo_key: String?
    var people: [Person]?
    var contactInfo: [Info] = [
        Info(infoType: .phoneNumber, title: InfoType.phoneNumber.rawValue, information: "224.260.1150", associatedProfiles: []),
        Info(infoType: .email, title: InfoType.email.rawValue, information: "fleet@gmail.com", associatedProfiles: [])
    ]
    
    init? (name: String, username: String, bio: String, photo_key: String?, people: [Person]) {
        self.name = name
        self.username = username
        self.bio = bio
        self.photo_key = photo_key
        self.people = people
        
        if (username == "lavalab") {
            contactInfo = [
            Info(infoType: .email, title: "website", information: "usclavalab.org", associatedProfiles: []),
            Info(infoType: .email, title: InfoType.email.rawValue, information: "usclavalab@gmail.com", associatedProfiles: []),
            Info(infoType: .facebook, title: InfoType.facebook.rawValue, information: "lavalabusc", associatedProfiles: []),
            Info(infoType: .instagram, title: InfoType.instagram.rawValue, information: "usclavalab", associatedProfiles: []),
            Info(infoType: .snapchat, title: InfoType.snapchat.rawValue, information: "lavalabusc", associatedProfiles: [])

            ]
        }
    }
    
    mutating func removeUserFromGroup(withUsername username: String) {
        var indexToRemoveAt: Int = -1;
        for (index, person) in people!.enumerated() {
            if person.username == username {
                indexToRemoveAt = index
                break;
            }
        }
        if (indexToRemoveAt > 0) {
            people!.remove(at: indexToRemoveAt)
        }
    }
}
