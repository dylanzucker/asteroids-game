//
//  APIService.swift
//  Hamburger 2
//
//  Created by Joann Lin on 3/17/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import Foundation

final class APIService {
    static let shared = APIService()
    
    func openService(for info: Info) {
        switch (info.infoType) {
        case .phoneNumber:
            ExternalInteractions().callNumber(phoneNumber: (info.information))
            return
        case .email:
            ExternalInteractions().sendEmail(address: (info.information))
            return
        case .facebook:
            let userID: String = "100003669274753"
            let appURL = URL(string: "fb://profile/\(userID)")!
            let webURL = URL(string: "https://www.facebook.com/\(info.information)")!
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:]) { (success) in print("opened fb app?: \(success)")}
            } else {
                UIApplication.shared.open(webURL, options: [:]) { (success) in print("opened fb url?: \(success)")}
            }
            
            /*  if fb id, allow appURL and WebURL with fb id
             *  else, only allow webURL with username
             */
            
            return
        case .instagram:
            let userID: String = "jorann_rin"
            let appURL = URL(string: "instagram://user?username=\(userID)")!
            let webURL = URL(string: "https://instagram.com/\(userID)")!
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:]) { (success) in print("opened insta app?: \(success)")}
            } else {
                UIApplication.shared.open(webURL, options: [:]) { (success) in print("opened insta url?: \(success)")}
            }
            return
        case .snapchat:
            let userID: String = "joannl15"
            let profileURL = URL(string: "https://www.snapchat.com/add/\(userID)")!
            if UIApplication.shared.canOpenURL(profileURL) {
                UIApplication.shared.open(profileURL, options: [:]) { (success) in print("opened snapchat app?: \(success)")}
            } else {
                print("failed to open snaptchat")
            }
            return
        case .youtube:
            let userID: String = "fitmencook"
            let appURL = URL(string: "youtube://www.youtube.com/user/\(userID)")!
            let webURL = URL(string: "https://www.youtube.com/user/\(userID)")!
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:]) { (success) in print("opened youtube app?: \(success)")}
            } else {
                UIApplication.shared.open(webURL, options: [:]) { (success) in print("opened youtube url?: \(success)")}
            }
            return
        case .linkedin:
            let userID: String = "joann-lin-1a87b3116"
            let appURL = URL(string: "linkedin://profile/\(userID)")!
            let webURL = URL(string: "https://www.linkedin.com/in/\(userID)")!
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:]) { (success) in print("opened linkedin app?: \(success)")}
            } else {
                UIApplication.shared.open(webURL, options: [:]) { (success) in print("opened linkedin url?: \(success)")}
            }
            return
        case .twitter:
            let userID: String = "j0ann_l1n"
            let appURL = URL(string: "twitter://user?screen_name=\(userID)")!
            let webURL = URL(string: "https://www.twitter.com/\(userID)")!
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:]) { (success) in print("opened linkedin app?: \(success)")}
            } else {
                UIApplication.shared.open(webURL, options: [:]) { (success) in print("opened linkedin url?: \(success)")}
            }

            return
        default:
            return
        }
    }
}
