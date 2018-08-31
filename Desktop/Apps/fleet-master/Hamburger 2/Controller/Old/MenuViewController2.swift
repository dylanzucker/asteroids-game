//
//  MenuViewController.swift
//  Hamburger 2
//
//  Created by Ryan Selden on 11/4/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit

class MenuViewController2: UITableViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    func myContactMenuClicked() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let person: Person? = appDelegate.myUser
        
        guard person != nil,
            let profileView = self.storyboard?.instantiateViewController(withIdentifier: ProfileTableViewController.storyboardID) as? ProfileTableViewController else {
                return
        }
        
        profileView.person = person
        self.navigationController?.pushViewController(profileView, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateMyUser), name: NSNotification.Name(rawValue: "updateMyUser"), object: nil)
        
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "myUserName")
        if (username != "") {
            updateMyUser()
        }

        // Do any additional setup after loading the view.
    }

    @objc func updateMyUser() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let newUser = appDelegate.myUser
        
        name.text = newUser?.name
        username.text = "@"+(newUser?.username)!
        
        userImage.image = UIImage(named: (newUser?.photo_key)!)
        userImage.layer.borderWidth = 1.0
        userImage.layer.borderColor = UIColor.clear.cgColor
        userImage.layer.masksToBounds = true
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
    }
    
    override func viewDidLayoutSubviews() {
        userImage.layer.borderWidth = 1.0
        userImage.layer.borderColor = UIColor.clear.cgColor
        userImage.layer.masksToBounds = true
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
