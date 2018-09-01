//
//  ProfileTableViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 11/11/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import Foundation
import BTNavigationDropdownMenu
import UIKit

class ProfileTableViewController: UITableViewController {
    // MARK: - Properties
    static let storyboardID = "ProfileTableViewController"
    var person: Person?
    var profiles: [String] = []
    var isOwnProfile: Bool = false
    var isConnected: Bool = false
        // shows connection between currentUser and person
    var profileShown: Int = 0 // public
    var randomProfile: Int = 0
    var infoShown: [Info] = []
    
    // MARK: - Outlets
    @IBOutlet var profileTableView: UITableView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fixStatusBarBug()

        // Set profile table settings
        setProfileTableView()

        // Configure profile
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            // if person is not set, then current user is accessing this page
            // otherwise, person MUST be set when controller is instantiated
            if person == nil {
                person = appDelegate.myUser
            }
            
            guard let person = person else {
                return
            }
            
            isOwnProfile = (appDelegate.myUser?.username == person.username)

            // own profile
            if (isOwnProfile) {
                profiles = person.profiles
                profiles.append("All")
                profileShown = 3
            }
            
            // foreign profile
            if (!isOwnProfile) {
                if let data = appDelegate.allData {
                    setIsConnectedToMe()
                    
    //                // jill specific
                    if (person.username == "jillrhodes") {
                        profileShown = -1
    //                    randomProfile = 1
                        return
                    }
                    
                    // generates number from 1 to 2 (friend, work)
                    // generates number from -1 to 0 (not sharing, public)
                    profileShown = isConnected ? Int(arc4random_uniform(2)) + 1 : -1
                    randomProfile = isConnected ? Int(arc4random_uniform(2)) + 1 : 0
                }
            }
        }        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Set navigation bar
        setNavigationBar()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
   
    private func setNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.removeNavigationBarUnderline()

        guard let person = person else {
            return
        }
        
        // Set middle navigation item
        self.navigationItem.titleView = NavigationTitleLabel(withText: "@"+person.username)
        
        // Set right navigation item
        let moreActionsImage = UIImage(named: "dotdotdot")?.withRenderingMode(.alwaysOriginal)
        let rightButtonItem = UIBarButtonItem.init(image: moreActionsImage, style: .plain, target: self, action: #selector(moreActionsClicked))
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        // Set left navigation item
        setBackButton()
    }
    
    // MARK: - Helper Functions
    private func setIsConnectedToMe() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let data = appDelegate.allData, let person = person {
            self.isConnected = data.isConnectedToMe(username: person.username)
        } else {
            self.isConnected = false
        }
    }
    
    private func setProfileTableView() {
        profileTableView.rowHeight = UITableViewAutomaticDimension
        profileTableView.estimatedRowHeight = 292
        profileTableView.separatorStyle = .none
        
        // Set table data source/delegate
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        profileTableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        profileTableView.estimatedSectionHeaderHeight = 272;
    }
    
    @objc func moreActionsClicked(sender: UIBarButtonItem) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: ProfileMenuViewController.storyboardID) as? ProfileMenuViewController, let appDelegate = UIApplication.shared.delegate as? AppDelegate, let foreignUser = person else {
            return
        }
        
        controller.modalPresentationStyle = .overCurrentContext;
        controller.currentUser = appDelegate.myUser
        controller.foreignUser = person
        controller.isConnected = isConnected
        
        self.navigationController?.present(controller, animated: false) {
            self.setIsConnectedToMe()
        }

//        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//
//        if (isOwnProfile) {
//            let manageProfilesButton = UIAlertAction(title: "Manage Profiles", style: .default, handler: { (action) -> Void in
//                print("manageProfilesButton button tapped")
//            })
//            let shareProfileButton = UIAlertAction(title: "Share Profile", style: .default, handler: { (action) -> Void in
//                print("shareProfileButton button tapped")
//            })
//
//            alertController.addAction(manageProfilesButton)
//            alertController.addAction(shareProfileButton)
//
//        } else {
//            let followAllButton = UIAlertAction(title: "Follow All", style: .default, handler: { (action) -> Void in
//                print("followAllButton button tapped")
//            })
//            let addToFavoritesButton = UIAlertAction(title: "Add To Favorites", style: .default, handler: { (action) -> Void in
//                print("addToFavoritesButton button tapped")
//            })
//
//            alertController.addAction(followAllButton)
//            alertController.addAction(addToFavoritesButton)
//
//            if (profileShown >= 0) {
//                let changeProfileButton = UIAlertAction(title: "Change Persona", style: .default, handler: { (action) -> Void in
//                    let alertController = UIAlertController(title: "Which persona would you like to share with " + (self.person?.name)! + "?", message: nil, preferredStyle: .actionSheet)
//                    let publicButton = UIAlertAction(title: "Public", style: .default, handler: { (action) -> Void in
//                        self.profileShown = 0
//                        self.tableView.reloadData()
//                    })
//                    let friendButton = UIAlertAction(title: "Social", style: .default, handler: { (action) -> Void in
//                        self.profileShown = 1
//                        self.tableView.reloadData()
//                    })
//                    let workButton = UIAlertAction(title: "Business", style: .default, handler: { (action) -> Void in
//                        self.profileShown = 2
//                        self.tableView.reloadData()
//                    })
//                    let familyButton = UIAlertAction(title: "Family", style: .default, handler: { (action) -> Void in
//                        self.profileShown = 3
//                        self.tableView.reloadData()
//                    })
//
//                    alertController.addAction(publicButton)
//                    alertController.addAction(friendButton)
//                    alertController.addAction(workButton)
//                    alertController.addAction(familyButton)
//
//                    self.navigationController!.present(alertController, animated: true, completion: nil)
//                })
//                alertController.addAction(changeProfileButton)
//            }
//            let shareProfileButton = UIAlertAction(title: "Share Profile", style: .default, handler: { (action) -> Void in
//                print("Cancel button tapped")
//            })
//            let disconnectButton = UIAlertAction(title: "Disconnect", style: .destructive, handler: { (action) -> Void in
//                print("Block button tapped")
//            })
//            let blockButton = UIAlertAction(title: "Block", style: .destructive, handler: { (action) -> Void in
//                print("Block button tapped")
//            })
//
//            alertController.addAction(shareProfileButton)
//            alertController.addAction(disconnectButton)
//            alertController.addAction(blockButton)
//        }
//
//        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
//            print("Cancel button tapped")
//        })
//
//        alertController.addAction(cancelButton)
//
    }
}


// MARK: - TableViewController Extension
extension ProfileTableViewController {
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //returns the number of rows to draw
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch(section) {
//        case 0:     // for profile header
//            return 1
//        case 1:     // for profile
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
//        default:
//            return 0
//        }
    }
    
    //makes rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
        //return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
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
        
        return profileHeader
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? InfoTableViewCell,
            let info = cell.info
            else {
            fatalError("click detected but action could not be taken")
            return
        }
        
        APIService.shared.openService(for: info)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let profileHeader = Bundle.main.loadNibNamed(ProfileSectionHeaderView.nibName, owner: nil, options: nil)?.first as? ProfileSectionHeaderView, let person = person, let bio = person.bio else {
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
    
    }
}
