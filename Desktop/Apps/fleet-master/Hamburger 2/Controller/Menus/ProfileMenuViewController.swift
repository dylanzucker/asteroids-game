//
//  ProfileMenuViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 5/30/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

class ProfileMenuViewController: UIViewController {
    static let storyboardID = "ProfileMenuViewController"
    var numberOfMenuRows: Int = 0
    var menuRowHeight: CGFloat = 0.0
    
    var currentUser: Person?
    var foreignUser: Person?    // person whose profile you are viewing
    var isConnected: Bool = false
    
    var currentUsersGroups: [Group]?
    
    var displayingGroups: Bool = false

    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var menuTableViewHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // MenuViewController specific
        self.view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapped)))

        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.menuTableView.separatorStyle = .none
        
        // ProfileMenuViewController specific
        numberOfMenuRows = 3
        menuRowHeight = 60.0

        setMenuHeight()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        print("height: \(menuTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.frame.height)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else {
            return
        }
        
        let point = sender.location(in: self.view)
        
        if !menuTableView.frame.contains(point) {
            print("Tapped outside the view")
            self.dismiss(animated: false, completion: nil)
        } else {
            print("Tapped inside the view")
        }
    }

    func setMenuHeight() {
        let height = CGFloat(numberOfMenuRows) * menuRowHeight
        menuTableViewHeight.constant = height
        //        menuTableView.layoutIfNeeded()
    }
}

extension ProfileMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
        if (displayingGroups) {
            // MARK: TODO - Create re-usable function
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return 0
            }

            let username = appDelegate.myUser!.username

            var searchArray = appDelegate.allData!.allGroups
            searchArray += appDelegate.allData!.searchGroups

            let groups = searchArray.filter({ (group) in
                return appDelegate.allData!.isMemberOf(username: username, group: group)
            })

            searchArray = searchArray.sorted(by: groupKey)
            currentUsersGroups = groups.sorted(by: groupKey)
            
            numberOfMenuRows = currentUsersGroups!.count + 1    // for top menu item
            setMenuHeight()
        }
        
        return numberOfMenuRows
    }
    
    private func groupKey(one: Group, two:Group) -> Bool {
        return one.name.lowercased() < two.name.lowercased()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseIdentifier) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        
        if (displayingGroups) {
            if (indexPath.row == 0) {
                cell.setLabelText(to: "Select a Group:")
                cell.setTextStyle(to: 1)
                cell.removeBottomBorder()
            } else {
                print("iP: \(indexPath.row)")
                let group = currentUsersGroups![indexPath.row - 1]
                cell.setLabelText(to: group.name)
                cell.setTextStyle(to: 2)
                cell.setBottomBorder(withThickness: 0.5)
            }
        } else {
            switch (indexPath.row) {
            case 0:
                if (isConnected) {
                    cell.setLabelText(to: "Remove \(foreignUser != nil ? foreignUser!.firstName : "person")")
                } else {
                    cell.setLabelText(to: "Add \(foreignUser != nil ? foreignUser!.firstName : "person")")
                }
                cell.onClick = {
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                        return
                    }

                    if (self.isConnected) {
                        // remove connection between currentUser and foreignUser
                        appDelegate.allData?.disconnectToMe(username: self.foreignUser!.username)
                    } else {
                        // add connection between currentUser and foreignUser
                        appDelegate.allData?.connectToMe(username: self.foreignUser!.username)
                    }
                    self.isConnected = !self.isConnected
                    self.dismiss(animated: false, completion: nil)
                }
                break
            case 1:
                cell.setLabelText(to: "Add to Group")
                cell.onClick = {
                    print("add to group")
                    self.displayingGroups = true
                    tableView.reloadData()
                }
                break
            case 2:
                cell.setLabelText(to: "Share Profile")
                cell.onClick = {
                    print("share profile")
                }
                break
            default:
                break
            }
            
            cell.setTextStyle(to: 1)
            cell.setBottomBorder(withThickness: 0.5)
        }
        
        return cell
    }
}
