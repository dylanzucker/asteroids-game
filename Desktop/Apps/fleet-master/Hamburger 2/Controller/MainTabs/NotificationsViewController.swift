//
//  ContactsViewController.swift
//  Hamburger 2
//
//  Created by Ryan Selden on 11/4/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    //the navigation hamgurger button
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var table: UITableView!
    
    //the main list of contacts
    var notifications: [Notification] = [Notification]()
    var requests: [FriendRequest] {
        // RYAN - load requests.. or at least see if there is at least 1 request
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let data = appDelegate.allData {
            return [FriendRequest.init(friender: data.getPersonByUsername(username: "rselden")!, friendee: data.getPersonByUsername(username: "jlin")!), FriendRequest.init(friender: data.getPersonByUsername(username: "amalamud")!, friendee: data.getPersonByUsername(username: "jlin")!), FriendRequest.init(friender: data.getPersonByUsername(username: "jturtel")!, friendee: data.getPersonByUsername(username: "jlin")!), FriendRequest.init(friender: data.getPersonByUsername(username: "cperkins")!, friendee: data.getPersonByUsername(username: "jlin")!)]
        } else {
            return []
        }
    }
    var numberOfSections = 0
    var tooManyRequests = false
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabViewSettings()
        
        // navigation set-up
        self.navigationItem.titleView = NavigationTitleLabel(withText: "Notifications")
        self.removeNavigationBarUnderline()

        // initialize the table
        table.preservesSuperviewLayoutMargins = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        // RYAN - to remove?
        self.initData()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // RYAN - to remove?
    //fills the people array with Person objects made from the csv file
    private func initData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        notifications += (appDelegate.allData?.allNotifications)!
        
    }
    
}

//table extension
extension NotificationsViewController: UITableViewDataSource, UITableViewDelegate {
    //we have one section (for now) multiple would be initials of names
    func numberOfSections(in tableView: UITableView) -> Int {
        numberOfSections = requests.count > 0 ? 2 : 1
        return numberOfSections
    }
    
    //returns the number of rows to draw
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch numberOfSections {
        // no requests, only notifications
        case 1:
            return notifications.count
        // notifications AND requests
        case 2:
            switch section {
            case 0:
                let maxRequestsShown = Constants.AppSettings.NotificationsPage.FriendRequests.maxNumberFriendRequestsShown
                // if more than MAX_NUMBER, then add "View more requests" row
                // always add extra row for "Requests" header
                tooManyRequests = requests.count > maxRequestsShown
                return tooManyRequests ? maxRequestsShown + 2 : requests.count + 1
            case 1:
                return notifications.count
            default:
                return 0
            }
        default:
            return 0
        }
    }
    
    //makes rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch numberOfSections {
        case 1:
            guard let cell = table.dequeueReusableCell(withIdentifier: NotificationTableViewCell.reuseIdentifier) as? NotificationTableViewCell else {
                return UITableViewCell()
            }
            cell.setInfo(for: notifications[indexPath.row])
        case 2:
            switch indexPath.section {
            case 0:
                if indexPath.row == 0 {
                    guard let cell = table.dequeueReusableCell(withIdentifier: "NotificationsTableViewCell") else {
                        return UITableViewCell()
                    }
                    cell.selectionStyle = .none
                    return cell
                }
                
                if tooManyRequests && indexPath.row == (1 + Constants.AppSettings.NotificationsPage.FriendRequests.maxNumberFriendRequestsShown) {
                    guard let cell = table.dequeueReusableCell(withIdentifier: SeeMoreRequestsTableViewCell.reuseIdentifier) else {
                        return UITableViewCell()
                    }                    
                    cell.setBottomBorder(withThickness: 0.5)
                    return cell
                }
                
                
                guard let cell = table.dequeueReusableCell(withIdentifier: FriendRequestTableViewCell.reuseIdentifier) as? FriendRequestTableViewCell else {
                    return UITableViewCell()
                }
                
                if !tooManyRequests && indexPath.row == requests.count {
                    cell.setBottomBorder(withThickness: 0.5)
                }
                
                let friender = requests[indexPath.row - 1].friender
                cell.setInfo(for: friender)
                cell.onClick = {
                    if let tabController = self.tabBarController,
                    let navController = tabController.navigationController {
                        self.goToProfile(of: friender, using: navController)
                    }
                }
                cell.hideButtons()
                return cell
            case 1:
                guard let cell = table.dequeueReusableCell(withIdentifier: NotificationTableViewCell.reuseIdentifier) as? NotificationTableViewCell else {
                    return UITableViewCell()
                }
                cell.setInfo(for: notifications[indexPath.row])
                cell.setBottomBorder(withThickness: 0.5)
                return cell
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.cellForRow(at: indexPath) as? FriendRequestTableViewCell != nil {
            return 57.0
        }
        
        if tableView.cellForRow(at: indexPath) as? NotificationTableViewCell != nil {
            return 83.0
        }
        
        return UITableViewAutomaticDimension
    }
    
    //when a row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let _ = tableView.cellForRow(at: indexPath) as? SeeMoreRequestsTableViewCell, let allFriendRequestsView = self.storyboard?.instantiateViewController(withIdentifier: AllFriendRequestsViewController.storyboardID) as? AllFriendRequestsViewController {
            
            // Set requests in all friend requests controller
            allFriendRequestsView.friendRequests = requests
            
            // Push to profile controller
            if let tbc = self.tabBarController {
                if let nc = tbc.navigationController {
                    nc.pushViewController(allFriendRequestsView, animated: true)
                    return
                }
            }
        }
        
       
        return
    }
    
    
}
