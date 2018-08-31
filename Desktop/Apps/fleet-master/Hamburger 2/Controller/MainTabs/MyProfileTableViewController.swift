//
//  MyProfileTableViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 5/21/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import Foundation
import BTNavigationDropdownMenu
import UIKit

class MyProfileTableViewController: UITableViewController, MyProfileMenuVCDelegate {
    // MARK: - Properties
    static let storyboardID = "MyProfileTableViewController"
    var person: Person? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.myUser
    }
    var profiles: [String] = []
    var isOwnProfile: Bool = true
    var isConnected: Bool = false
    // shows connection between currentUser and person
    var profileShown: Int = 0 // public
    var randomProfile: Int = 0
    var infoShown: [Info] = []
//    var rowsAreClickable: Bool = true
    
    // MARK: - Outlets
    @IBOutlet var profileTableView: UITableView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        
        guard let person = self.person else {
            return
        }
        
        super.viewDidLoad()
        self.setTabViewSettings()

        profileTableView.rowHeight = UITableViewAutomaticDimension
        profileTableView.estimatedRowHeight = 292
        profileTableView.separatorStyle = .none
        
        // Set table data source/delegate
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        profileTableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        profileTableView.estimatedSectionHeaderHeight = 272;
        
   
        // own profile
        if (isOwnProfile) {
            profiles = person.profiles
            profiles.append("All")
            profileShown = 3
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // hide nav bar
        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.setBackButtonBackgroundImage(UIImage(named: "back_arrow"), for: .normal, barMetrics: .default)
        self.navigationItem.backBarButtonItem = backItem
        
        if let identifier = segue.identifier {
            switch identifier {
            case "openSettings":
                print("open settings detected")
                break
            default:
                break
            }
        }
    }
    
    func MyProfileMenuVCDelegateFunc(someRandomString: String) {
        print(someRandomString)
        performSegue(withIdentifier: "openSettings", sender: self)
    }
    
    // MARK: - Helper Functions
    @objc func moreActionsClicked() {
        print("more actions called")
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: MyProfileMenuViewController.storyboardID) as? MyProfileMenuViewController, let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        controller.modalPresentationStyle = .overCurrentContext;
        controller.currentUser = appDelegate.myUser
        controller.foreignUser = person
        controller.isConnected = isConnected
        controller.delegate = self
        
//        rowsAreClickable = false
        self.navigationController?.present(controller, animated: false) {
//            self.rowsAreClickable = true
        }
    }
}


// MARK: - TableViewController Extension
extension MyProfileTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //returns the number of rows to draw
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:     // for profile header
            return 1
        case 1:     // for profile
            guard let person = person else {
                return 0;
            }
            var count = 0;
            infoShown = [];
            
            if (isOwnProfile) {
                person.contactInfo.forEach({ info in
                    if (info.associatedProfiles.contains(profileShown) || profileShown > person.profiles.count - 1) {
                        count += 1
                        infoShown.append(info)
                    }
                })
            } else {
                // don't know which profile is being shared with you
                // if not connected, public profile (0)
                // if connected, random profile (0-2)
                person.contactInfo.forEach({ info in
                    if (info.associatedProfiles.contains(randomProfile) || profileShown > person.profiles.count - 1) {
                        count += 1
                        infoShown.append(info)
                    }
                })
            }
            
            return count
        default:
            return 0
        }
    }
    
    //makes rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("generating cell for section: \(indexPath.section) row: \(indexPath.row)")
        switch(indexPath.section) {
        case 0:
            guard let cell = profileTableView.dequeueReusableCell(withIdentifier: ProfileHeaderTableViewCell.reuseIdentifier, for: indexPath) as? ProfileHeaderTableViewCell else {
                fatalError("The dequeued cell is not an instance of ProfileHeaderTableViewCell.")
            }

            cell.setUsername(to: (person?.username)!)
            cell.moreActionsClicked = {
                self.moreActionsClicked()
            }
            return cell
        case 1:
            guard let cell = profileTableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.reuseIdentifier, for: indexPath) as? InfoTableViewCell else {
                fatalError("The dequeued cell is not an instance of InfoTableViewCell.")
            }
            
            let info = infoShown[indexPath.row]
            cell.setInfo(for: info)
            
            if (info.infoType == .email || info.infoType == .phoneNumber) {
                cell.hideConnectButton()
                //                cell.addBottomSpace()
            }
            
            if (info.infoType == .email || info.infoType == .phoneNumber || isOwnProfile) {
                cell.hideConnectButton()
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.section) {
        case 0:
            if let navBarHeight = self.tabBarController?.navigationController?.navigationBar.frame.height {
                return navBarHeight
            } else {
                return 0
            }
        case 1:
            return 105
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch(section) {
        case 0:
            return nil
        case 1:
            guard let person = person, let profileHeader = Bundle.main.loadNibNamed(ProfileSectionHeaderView.nibName, owner: nil, options: nil)?.first as? ProfileSectionHeaderView else {
                return nil
            }
            
            profileHeader.setInfo(for: person, withScreenWidth: view.frame.width)
            profileHeader.showProfile = { (profileNum) in
                self.randomProfile = profileNum
                if (profileNum == 0) {
                    self.profileShown = -1
                } else {
                    self.profileShown = 1
                }
                self.tableView.reloadData()
            }
            if (isOwnProfile) {
                if (profileShown == 3) {
                    profileHeader.setProfile(to: "")
                    return profileHeader
                }
                profileHeader.setProfile(to: profiles[profileShown])
            } else {
                if (profileShown < 0) {
                    profileHeader.setProfile(to: nil)
                } else {
                    profileHeader.setProfile(to: person.profiles[profileShown])
                    
                }
            }
            profileHeader.layer.borderColor = UIColor.black.cgColor
            profileHeader.layer.borderWidth = 0.5
            return profileHeader
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 { // only if contact info section
            guard let cell = tableView.cellForRow(at: indexPath) as? InfoTableViewCell,
                let info = cell.info
                else {
                    print("detected click at \(indexPath) for cell \(tableView.cellForRow(at: indexPath).debugDescription)")
                    fatalError("click detected but action could not be taken")
                    return
            }
            
            APIService.shared.openService(for: info)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return 0
        case 1:
            guard let person = person, let bio = person.bio else {
                return 230 // default max size
            }
            var cellHeight: CGFloat = 152   // profile bio Label y value
            let font: UIFont = UIFont(name: "Avenir-Roman", size: 14.0)!
            let text = bio as NSString
            let constraintSize: CGSize = CGSize(width: 343.0, height: CGFloat.greatestFiniteMagnitude)
            let size: CGRect = text.boundingRect(with: constraintSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: font], context: nil)
            cellHeight += (size.height > 19.124 ? (19.124 * 2.0) : 19.124) + 30; //you can also add a cell padding if you want some space below textView
            print(cellHeight)
            
            return cellHeight
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
