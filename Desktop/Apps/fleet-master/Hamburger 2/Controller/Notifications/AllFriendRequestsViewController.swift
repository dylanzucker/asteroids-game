//
//  AllFriendRequestsTableViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 1/1/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

class AllFriendRequestsTableViewController: UITableViewController {
    
    static let storyboardID = "AllFriendRequestsTableViewController"
    var friendRequests: [FriendRequest] = [FriendRequest]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation bar settings
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setBackButton()

        // table settings
        self.tableView.separatorStyle = .none
        
        // RYAN - set friendrequests to all pending friend requests to user
        // friendRequests =
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendRequests.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendRequestTableViewCell.reuseIdentifier, for: indexPath) as? FriendRequestTableViewCell else {
            return UITableViewCell()
        }

        let friender = friendRequests[indexPath.row].friender
        cell.setInfo(for: friender)
        cell.onClick = {
            self.goToProfile(of: friender, using: self.navigationController)
        }
        cell.clickedAccept = {
            // RYAN - add connection between users; delete request
            
            // Delete cell
            self.deleteCellandData(at: indexPath, requestAccepted: true)
        }
        cell.clickedDecline = {
            // RYAN - delete request
            
            // Delete cell
            self.deleteCellandData(at: indexPath, requestAccepted: false)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.cellForRow(at: indexPath) as? FriendRequestTableViewCell != nil {
            return 65.0
        }
        return UITableViewAutomaticDimension
    }
    
    private func deleteCellandData(at indexPath: IndexPath, requestAccepted: Bool) {
        let animationDuration = Constants.AppSettings.NotificationsPage.FriendRequests.cellFadeAnimationDuration ?? 0.5
        
        DispatchQueue.main.async() {
            self.tableView.beginUpdates()
            UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseOut, animations: {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.friendRequests.remove(at: indexPath.row)
            }, completion: { (finished) in
                self.tableView.endUpdates()
                self.tableView.reloadData()
                if (requestAccepted) {
                    self.openConnectionMenu()
                }
            })
        }
    }
 
    private func openConnectionMenu() {

        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: MyProfileMenuViewController.storyboardID) as? MyProfileMenuViewController, let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        controller.modalPresentationStyle = .overCurrentContext;
        controller.modalTransitionStyle = .crossDissolve
        controller.currentUser = appDelegate.myUser
        controller.foreignUser = appDelegate.myUser
        controller.isConnected = true
        controller.delegate = nil
        
        //        rowsAreClickable = false
        self.navigationController?.present(controller, animated: false) {
            //            self.rowsAreClickable = true
        }
    }

    private func setConnection() {

//        if !UIAccessibilityIsReduceTransparencyEnabled() {
//
//            let blurEffect = UIBlurEffect(style: .extraLight)
//            let blurEffectView = UIVisualEffectView(effect: blurEffect)
//            blurEffectView.alpha = 0.5
//            //always fill the view
//            blurEffectView.frame = (UIApplication.shared.keyWindow?.frame)!
//            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//            let currentWindow = UIApplication.shared.keyWindow
//            self.view.addSubview(blurEffectView)
//
//            let animationDuration = Constants.AppSettings.NotificationsPage.FriendRequests.acceptedRequestConnectPageFadeInDuration ?? 0.5
//
//            DispatchQueue.main.async() {
//                if #available(iOS 10.0, *) {
//                    let animator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeIn) {
//                        blurEffectView.effect = UIBlurEffect(style: .light)
//                    }
//
//                    animator.startAnimation()
//                } else {
//                    // Fallback on earlier versions
//                    UIView.animate(withDuration: animationDuration) {
//                        blurEffectView.effect = UIBlurEffect(style: .light)
//                    }
//                }
//            }
//
//        } else {
//            view.backgroundColor = .black
//        }
    }

}
