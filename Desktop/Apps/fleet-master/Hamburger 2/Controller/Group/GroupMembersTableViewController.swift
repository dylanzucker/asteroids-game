//
//  GroupMembersViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 11/13/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit

class GroupMembersTableViewController: UITableViewController {
    @IBOutlet weak var searchBarView: UIView!

    static let storyboardID = "GroupMembersTableViewController"
    let searchController = UISearchController(searchResultsController: nil)
    var members: [Person] = []

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.separatorInset = .zero
        self.tableView.separatorStyle = .none
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        searchBarView.addSubview(searchController.searchBar)
        searchController.searchBar.placeholder = "Search by name or username…"
        searchController.searchBar.isUserInteractionEnabled = false
        
//        self.setBackButtonImage()
    }
}

extension GroupMembersTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //returns the number of rows to draw
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    //makes rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let baseCell = self.tableView.dequeueReusableCell(withIdentifier: ContactTableCell.reuseIdentifier) as? ContactTableCell else {
            return UITableViewCell()
        }
        baseCell.person = members[indexPath.row]
        baseCell.update()
        return baseCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToProfile(of: members[indexPath.row], using: self.navigationController)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (45 * 1.3)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return (45 * 1.3)
    }
}

