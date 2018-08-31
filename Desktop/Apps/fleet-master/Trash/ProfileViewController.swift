//
//  ProfileViewController.swift
//  Fleet Sandbox
//
//  Created by Ryan Selden on 11/2/17.
//  Copyright © 2017 Ryan Selden. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var facebook: UILabel!
    
    // MARK: - Actions
    @IBOutlet weak var connectButtonButton: UIButton!
    @IBAction func connectButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.allData?.connectToMe(username: (person?.username)!)
        hideConnectButton()
        let alertController = UIAlertController(title: "fleet", message:
            "You are now connected to @"+(person?.username)!+"!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
    }
    
    @IBAction func phoneButton(_ sender: Any) {
        ExternalInteractions().callNumber(phoneNumber: (person?.phone)!)
    }
    @IBAction func messageButton(_ sender: Any) {
        ExternalInteractions().sendText(address: (person?.phone)!)
    }
    @IBAction func emailButton(_ sender: Any) {
        ExternalInteractions().sendEmail(address: (person?.email)!)
    }
    @IBAction func plusButton(_ sender: Any) {
        ExternalInteractions().openFacebook(username: "100015989588951")
    }
    
    // MARK: - Properties
    var person: Person?
    
    static let storyboardID = "profileViewController"
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.update()
        // Do any additional setup after loading the view.
    }
    
    func hideConnectButton() {
        connectButtonButton.isHidden = true
    }
    
    func update() {
        guard let person = person else {
            return
        }
        
        //username.text = "@"+person.username!
        image.image = UIImage(named: person.photo_key!)
        name.text = person.name
        bio.text = person.bio
        phone.text = person.phone
        email.text = person.email
        facebook.text = person.facebook
        
//        self.navigationItem.title = "@"+person.username
        self.navigationItem.titleView = NavigationTitleLabel.init(withText: "@"+person.username)

        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if (appDelegate.allData?.isConnectedToMe(username: person.username))! {
                hideConnectButton()
            }
        }
        
        image.layer.borderWidth = 1.0
        image.layer.borderColor = UIColor.clear.cgColor
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        //        phoneView.setBottomBorder()
        //        emailView.setBottomBorder()
        //        facebookView.setBottomBorder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        image.layer.cornerRadius = image.bounds.size.width/2
    }
    
    
}

