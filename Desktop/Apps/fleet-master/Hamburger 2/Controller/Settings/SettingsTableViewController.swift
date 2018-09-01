    //
//  SettingsTableViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 11/26/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    // MARK: - Properties
    var viewingSettings: Bool = false
    var headers: [String] = ["Account", "Notifications", "Support", "About"]
    var settings: [[String]] = [
            ["Add Accounts", "IDs", "Edit Profile", "Password"],
            ["Sound", "Push Notifications", "Email Notifications"],
            ["Help", "Feedback"],
            ["Privacy Policy", "Terms"]
    ]
    
    // MARK: - Outlets

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.sectionFooterHeight = 0.0;

        
        self.fixStatusBarBugSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if (!viewingSettings) {
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setNavigationBar() {
        // set nav bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.removeNavigationBarUnderline()
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.tintColor = UIColor.green
        self.navigationController!.navigationBar.barTintColor = UIColor.red
            //UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        
        // middle nav item
        self.navigationItem.titleView = NavigationTitleLabel(withText: "Settings")
        
        //  left nav item
        let button: UIButton = UIButton (type: .custom)
        button.setImage(UIImage(named: "back_arrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc override func backButtonPressed(btn : UIButton) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath) as? SettingsTableViewCell else {
            fatalError("The dequeued cell is not an instance of SettingsTableViewCell.")
        }
        
        // Configure the cell...
        cell.settingName.text = settings[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 77.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsHeaderTableViewCell.reuseIdentifier) as? SettingsHeaderTableViewCell else {
            fatalError("The dequeued cell is not an instance of SettingsHeaderTableViewCell.")
        }
        
        cell.settingsHeader.text = headers[section]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            switch indexPath.row {
            case 0:
                UINavigationBar.appearance().barTintColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
                return
            case 1:
                guard let createIDsTVC = self.storyboard?.instantiateViewController(withIdentifier: CreateIDsTableViewController.identifier) as? CreateIDsTableViewController else {
                    return
                }
                self.navigationController?.pushViewController(createIDsTVC, animated: true)
                return
            case 2: // temp OAuth
//                guard let changeUserView = self.storyboard?.instantiateViewController(withIdentifier: "TempViewController") as? TempViewController else {
//                    return
//                }
//                self.navigationController?.pushViewController(changeUserView, animated: true)
                return
            case 3: // temp Login
//                guard let changeUserView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
//                    return
//                }
//                self.navigationController?.pushViewController(changeUserView, animated: true)
                return
            default:
                return
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
