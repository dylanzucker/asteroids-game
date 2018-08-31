//
//  Person.swift
//  Fleet Sandbox
//
//  Created by Ryan Selden on 11/1/17.
//  Copyright © 2017 Ryan Selden. All rights reserved.
//

import Foundation
import UIKit

class Person {
    // consider making this var __ : String
    let bio: String?
    let phone: String?
    let email: String?
    let facebook: String?
    let photo_key: String?
    
    var contactInfo = [Info]()
    var profiles = ["Public", "Social", "Business", "Family"]
    
    var name: String = ""
    var username: String = ""
    var firstName: String = ""
    var lastName: String = ""
    
    init () {
        bio = ""
        phone = ""
        email = ""
        facebook = ""
        photo_key = ""
    }
    
    init? (name: String, username: String, bio: String, phone: String, email: String, facebook: String, photo_key: String?) {
        self.name = name
        self.username = username
        self.bio = bio
        self.phone = phone
        self.email = email
        self.facebook = facebook
        self.photo_key = photo_key
        
        if (username == "jillrhodes") {
            addJillInfo(phone: phone, email: email, facebook: facebook)
            return
        }
        
        var components = name.components(separatedBy: " ")
        if(components.count > 0)
        {
            firstName = components.removeFirst()
            lastName = components.joined(separator: " ")
        }
        
        contactInfo.append(Info(infoType: InfoType.phoneNumber, title: InfoType.phoneNumber.rawValue, information: phone, associatedProfiles: [1,2,3]))
        contactInfo.append(Info(infoType: InfoType.email, title: InfoType.email.rawValue, information: email, associatedProfiles: [0,1,2]))
        contactInfo.append(Info(infoType: InfoType.facebook, title: InfoType.facebook.rawValue, information: facebook, associatedProfiles: [1,3]))
        generateInfo()
    }
    
    init (name: String, username: String, bio: String, photo_key: String?) {
        self.name = name
        self.username = username
        self.bio = bio
        self.photo_key = photo_key
        
        self.email = nil
        self.facebook = nil
        self.phone = nil
    }
    
    func addInfo(info: Info) {
        contactInfo.append(info)
    }
    
    func generateInfo() {
        // instagram - friend
        if (arc4random_uniform(2) == 0) {
            contactInfo.append(Info(infoType: .instagram, title: InfoType.instagram.rawValue, information: generateUsername(), associatedProfiles: [1]))
        }
        
        // snapchat - friend
        if (arc4random_uniform(2) == 0) {
            contactInfo.append(Info(infoType: .snapchat, title: InfoType.snapchat.rawValue, information: generateUsername(), associatedProfiles: [1]))
        }
        
        // twitter - friend
        if (arc4random_uniform(2) == 0) {
            contactInfo.append(Info(infoType: .twitter, title: InfoType.twitter.rawValue, information: generateUsername(), associatedProfiles: [1]))
        }
        
        // youtube - friend
        if (arc4random_uniform(2) == 0) {
            contactInfo.append(Info(infoType: .youtube, title: InfoType.youtube.rawValue, information: generateUsername(), associatedProfiles: [1]))
        }
        
        // pinterest - friend
        if (arc4random_uniform(2) == 0) {
            contactInfo.append(Info(infoType: .pinterest, title: InfoType.pinterest.rawValue, information: generateUsername(), associatedProfiles: [1]))
        }
        
        // linkedin - work
        contactInfo.append(Info(infoType: .linkedin, title: InfoType.linkedin.rawValue, information: generateUsername(), associatedProfiles: [2]))
    }
    
    func generateUsername() -> String {
        let randomNum = arc4random_uniform(6) + 1
        
        switch randomNum {
        case 0: return username
        case 1: return username + "\(Int(arc4random_uniform(100)) + 1)"
        case 2: return facebook!
        case 3: return facebook! + "\(Int(arc4random_uniform(100)) + 1)"
        case 4: return facebook! + "_\(Int(arc4random_uniform(100)) + 1)"
        case 5: return username + "_\(Int(arc4random_uniform(100)) + 1)"
        default:
            return username
        }
    }
    
    func addJillInfo(phone: String, email: String, facebook: String) {
        contactInfo.append(Info(infoType: InfoType.phoneNumber, title: InfoType.phoneNumber.rawValue, information: phone, associatedProfiles: [1,2]))
        contactInfo.append(Info(infoType: InfoType.email, title: InfoType.email.rawValue, information: email, associatedProfiles: [0,1,2]))
        contactInfo.append(Info(infoType: InfoType.facebook, title: InfoType.facebook.rawValue, information: "jilllrhodes", associatedProfiles: [1]))
        contactInfo.append(Info(infoType: .instagram, title: InfoType.instagram.rawValue, information: "j.rhodes", associatedProfiles: [1]))
        contactInfo.append(Info(infoType: .snapchat, title: InfoType.snapchat.rawValue, information: "jillyrhodes", associatedProfiles: [1]))
        contactInfo.append(Info(infoType: .custom, title: "soundcloud", information: "dj_jilliza", associatedProfiles: [1]))
        contactInfo.append(Info(infoType: .custom, title: "vsco", information: "jill_in_la", associatedProfiles: [1]))
        contactInfo.append(Info(infoType: .custom, title: "venmo", information: "jillrhodes14", associatedProfiles: [1]))
    }
}

