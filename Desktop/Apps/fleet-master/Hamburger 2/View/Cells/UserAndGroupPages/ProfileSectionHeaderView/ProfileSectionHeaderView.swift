//
//  ProfileSectionHeaderView.swift
//  Hamburger 2
//
//  Created by Joann Lin on 11/11/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit

class ProfileSectionHeaderView: UIView {

    // MARK: - Properties
    static let nibName = "ProfileSectionHeaderView"
    let photoSize: CGFloat = 100.0
    var username: String?
    var isOwnProfile: Bool = false
    var isConnected: Bool = false
    
    var showProfile: (Int) -> () = {(int) in }

    // MARK: - Outlets
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bio: UILabel!
//    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var connectButtonButton: UIButton!

    // MARK: - Initialization
//    init(person: Person?) {
//        let screenWidth = UIScreen.main.bounds.width
//        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth * 0.906))
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    
    func setInfo(for person: Person, withScreenWidth screenWidth: CGFloat) {
        
        if let photoName = person.photo_key {
            photo.image = UIImage(named: photoName)
        }
        name.text = person.name
        bio.text = person.bio
        
        username = person.username
        
        photo.circleBorder(withCornerRadius: photoSize/2)
//        photo.layer.cornerRadius = photoSize/2
//        photo.layer.borderWidth = 1.0
//        photo.layer.borderColor = UIColor.clear.cgColor
//        photo.layer.masksToBounds = true
//        photo.clipsToBounds = true
//        photo.contentMode = .scaleAspectFill
                
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let data = appDelegate.allData {
            isOwnProfile = (appDelegate.myUser?.username == person.username)
            
            if (isOwnProfile) {
                connectButtonButton.isHidden = true
            } else {
                isConnected = data.isConnectedToMe(username: person.username)
                self.setConnectButton()
            }
        }
        
//        self.setBottomBorder()
    }
    
    func setInfo(for group: Group, withScreenWidth screenWidth: CGFloat) {
        
        if let photoName = group.photo_key {
            photo.image = UIImage(named: photoName)
        }
        name.text = group.name
        bio.text = group.bio
        
        username = group.username
        
        photo.layer.cornerRadius = photoSize/2
        photo.layer.borderWidth = 1.0
        photo.layer.borderColor = UIColor.clear.cgColor
        photo.layer.masksToBounds = true
        photo.clipsToBounds = true
        photo.contentMode = .scaleAspectFill
        
        self.setConnectButton()
        //        self.setBottomBorder()
    }
    
    func setProfile(to profileName: String?) {
//        if let profileName = profileName {
//            profileLabel.text = profileName
//        } else {
//            profileLabel.text = nil
//        }
    }
    
    // MARK: - Connecting/Unconnecting
    func setConnectButton() {
//        if (isConnected) {
//            connectButtonButton.setImage(UIImage(named: "check_button"), for: .normal)
//            showProfile(1)
//        } else {
//            connectButtonButton.setImage(UIImage(named: "plus_button"), for: .normal)
//            showProfile(0)
//        }
        connectButtonButton.isHidden = true
    }
    
    @IBAction func connectButtonPressed(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let data = appDelegate.allData else {
            return
        }
        
        if (isConnected) {
           data.disconnectToMe(username: username!)
            isConnected = false
        } else {
            data.connectToMe(username: username!)
            isConnected = true
//            let alertController = UIAlertController(title: "fleet", message:
//                "You are now connected to @"+username!+"!", preferredStyle: UIAlertControllerStyle.alert)
//            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        }
        self.setConnectButton()
    }
    
}
