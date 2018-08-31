//
//  MyProfileViewController.swift
//  Hamburger 2
//
//  Created by Ryan Selden on 11/27/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class MyProfileViewController: UITableViewController {

    
    // MARK: - Properties
    // shows connection between currentUser and person
    static let storyboardID = "MyProfileViewController"
    var person: Person?
    var profiles: [String] = []
    var isOwnProfile: Bool = true
    var profileShown: Int = 0 // public
    var infoShown: [Info] = []
    
    // MARK: - Outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var profileTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fixStatusBarBug()
        
        if self.revealViewController() != nil {
            
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }

        profileTableView.rowHeight = UITableViewAutomaticDimension
        profileTableView.estimatedRowHeight = 292
        profileTableView.separatorStyle = .none
        
        // Set table data source/delegate
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        profileTableView.sectionHeaderHeight = UITableViewAutomaticDimension
        profileTableView.estimatedSectionHeaderHeight = 272
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            if person == nil {
                person = appDelegate.myUser
            }
            
            guard let person = person else {
                return
            }
            profiles = person.profiles
            profiles.append("All")
            profileShown = 4
            
            setNavigationBarItems()
        }
    }
//
//        // MARK: - Navigation
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            let backItem = UIBarButtonItem()
//            backItem.setBackButtonBackgroundImage(UIImage(named: "back_arrow"), for: .normal, barMetrics: .default)
//            self.navigationItem.backBarButtonItem = backItem
//        }
        
        private func setNavigationBarItems() {
            self.removeNavigationBarUnderline()

            guard let person = person else {
                return
            }
            
            // Set middle navigation item
            guard let navigationController = self.navigationController else {
                print("navigation controller not foun")
                return
            }
            let menuView = BTNavigationDropdownMenu(navigationController: navigationController, containerView: navigationController.view, title: "@"+person.username, items: profiles)
            menuView.navigationBarTitleFont = UIFont(name: "Avenir Book", size: 18.0)
            menuView.cellTextLabelFont = UIFont(name: "Avenir Book", size: 18.0)
            menuView.arrowImage = UIImage(named: "arrow")?.withRenderingMode(.alwaysOriginal)
            menuView.arrowTintColor = .black
            menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
                if let weakSelf = self {
                    weakSelf.profileShown = indexPath
                    weakSelf.tableView.reloadData()
                }
            }
            self.navigationItem.titleView = menuView
            
            // Set right navigation item
            let moreActionsImage = UIImage(named: "dotdotdot")?.withRenderingMode(.alwaysOriginal)
            let rightButtonItem = UIBarButtonItem.init(image: moreActionsImage, style: .plain, target: self, action: #selector(moreActionsClicked))
            self.navigationItem.rightBarButtonItem = rightButtonItem
            
            // Set left navigation item
            // set in contacts view controller
        }
        
        // MARK: - Helper Functions
        @objc func moreActionsClicked(sender: UIBarButtonItem) {
            print("more actions called")
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            if (isOwnProfile) {
                let manageProfilesButton = UIAlertAction(title: "Manage Profiles", style: .default, handler: { (action) -> Void in
                    print("manageProfilesButton button tapped")
                })
                let shareProfileButton = UIAlertAction(title: "Share Profile", style: .default, handler: { (action) -> Void in
                    print("shareProfileButton button tapped")
                })
                
                alertController.addAction(manageProfilesButton)
                alertController.addAction(shareProfileButton)
                
            } else {
                let followAllButton = UIAlertAction(title: "Follow All", style: .default, handler: { (action) -> Void in
                    print("followAllButton button tapped")
                })
                let addToFavoritesButton = UIAlertAction(title: "Add To Favorites", style: .default, handler: { (action) -> Void in
                    print("addToFavoritesButton button tapped")
                })
                
                alertController.addAction(followAllButton)
                alertController.addAction(addToFavoritesButton)
                
                if (profileShown >= 0) {
                    let changeProfileButton = UIAlertAction(title: "Change Persona", style: .default, handler: { (action) -> Void in
                        let alertController = UIAlertController(title: "Which persona would you like to share with " + (self.person?.name)! + "?", message: nil, preferredStyle: .actionSheet)
                        let publicButton = UIAlertAction(title: "Public", style: .default, handler: { (action) -> Void in
                            self.profileShown = 0
                            self.tableView.reloadData()
                        })
                        let friendButton = UIAlertAction(title: "Social", style: .default, handler: { (action) -> Void in
                            self.profileShown = 1
                            self.tableView.reloadData()
                        })
                        let workButton = UIAlertAction(title: "Business", style: .default, handler: { (action) -> Void in
                            self.profileShown = 2
                            self.tableView.reloadData()
                        })
                        let familyButton = UIAlertAction(title: "Family", style: .default, handler: { (action) -> Void in
                            self.profileShown = 3
                            self.tableView.reloadData()
                        })
                        
                        alertController.addAction(publicButton)
                        alertController.addAction(friendButton)
                        alertController.addAction(workButton)
                        alertController.addAction(familyButton)

                        self.navigationController!.present(alertController, animated: true, completion: nil)
                    })
                    alertController.addAction(changeProfileButton)
                }
                let shareProfileButton = UIAlertAction(title: "Share Profile", style: .default, handler: { (action) -> Void in
                    print("Cancel button tapped")
                })
                let disconnectButton = UIAlertAction(title: "Disconnect", style: .destructive, handler: { (action) -> Void in
                    print("Block button tapped")
                })
                let blockButton = UIAlertAction(title: "Block", style: .destructive, handler: { (action) -> Void in
                    print("Block button tapped")
                })
                
                alertController.addAction(shareProfileButton)
                alertController.addAction(disconnectButton)
                alertController.addAction(blockButton)
            }
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
                print("Cancel button tapped")
            })
            
            alertController.addAction(cancelButton)
            
            self.navigationController!.present(alertController, animated: true, completion: nil)
        }
    }
    
    
// MARK: - TableViewController Extension
extension MyProfileViewController {
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //returns the number of rows to draw
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let person = person else {
            return 0;
        }
        var count = 0;
        infoShown = [];
        
        person.contactInfo.forEach({ info in
            if (info.associatedProfiles.contains(profileShown) || profileShown > person.profiles.count - 1) {
                count += 1
                infoShown.append(info)
            }
        })
        
        return count
    }
    
    //makes rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = profileTableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.reuseIdentifier, for: indexPath) as? InfoTableViewCell else {
            fatalError("The dequeued cell is not an instance of InfoTableViewCell.")
        }
        
        let info = infoShown[indexPath.row]
        cell.setInfo(for: info)
        cell.hideConnectButton()
        
        if (info.infoType == .email || info.infoType == .phoneNumber) {
//            cell.addBottomSpace()
        }
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //        let profileHeader = ProfileSectionHeaderView(person: person)
        
        guard let person = person, let profileHeader = Bundle.main.loadNibNamed(ProfileSectionHeaderView.nibName, owner: nil, options: nil)?.first as? ProfileSectionHeaderView else {
            return nil
        }
        
        profileHeader.setInfo(for: person, withScreenWidth: view.frame.width)
        
        if (profileShown == 4) {
            profileHeader.setProfile(to: "")
            return profileHeader
        }
        profileHeader.setProfile(to: profiles[profileShown])        
        return profileHeader
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? InfoTableViewCell,
            let info = cell.info
            else {
                print("click detected but action could not be taken")
                return
        }
        
        APIService.shared.openService(for: info)

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let profileHeader = Bundle.main.loadNibNamed(ProfileSectionHeaderView.nibName, owner: nil, options: nil)?.first as? ProfileSectionHeaderView else {
            return 300
        }
        
        return profileHeader.frame.height
    }
}
