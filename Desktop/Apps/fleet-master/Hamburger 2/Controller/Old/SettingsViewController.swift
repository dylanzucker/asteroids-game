//
//  SettingsViewController.swift
//  Hamburger 2
//
//  Created by Ryan Selden on 11/4/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Properties
    var headers: [String] = ["Account", "Notifications", "Support", "About"]
    
    // MARK: - Outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var usernameField: UITextField!
    @IBAction func setUsername(_ sender: Any) {
        let newUsername = usernameField.text
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let newUser = appDelegate.allData?.getPersonByUsername(username: newUsername!)
        
        if newUser != nil {
            appDelegate.myUser = newUser
        }
        
        let defaults = UserDefaults.standard
        defaults.set(newUser?.username, forKey: "myUserName")
        defaults.synchronize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateMyUser"), object: nil)
        
        usernameField.text = ""
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameField.autocorrectionType = .no
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        self.navigationItem.titleView = NavigationTitleLabel(withText: "Settings")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
