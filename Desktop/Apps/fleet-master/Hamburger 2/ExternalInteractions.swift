//
//  ExternalInteractions.swift
//  Hamburger 2
//
//  Created by Ryan Selden on 11/5/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import Foundation
import MessageUI

class ExternalInteractions {
    func callNumber(phoneNumber:String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func sendText(address:String) {
        guard let messageURL = URL(string: "sms:\(address)")
            else { return }
        if UIApplication.shared.canOpenURL(messageURL) {
            UIApplication.shared.open(messageURL)
        }
    }
    
    func sendEmail(address:String) {
        if let url = URL(string: "mailto:\(address)") {
            UIApplication.shared.open(url)
        }
    }
    
    func openFacebook(username:String) {
        let appURL = URL(string: "fb://profile/\(username)")!
        let webURL = URL(string: "https://facebook.com/\(username)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
}
