//
//  ContactsViewController.swift
//  Hamburger 2
//
//  Created by Ryan Selden on 11/4/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController {
    
    // MARK: - Properties
    static let storyboardID = "GroupsViewController"
    //the main list of contacts
    var groups: [Group] = [Group]()
    //the list of contacts that filter through the current search
    var searchResults: [Group] = [Group]()
    var searchArray: [Group] = [Group]()
    
    // MARK: - IBOutlets
    //the navigation hamgurger button
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var table: UITableView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fixStatusBarBug()

        //this connects us to the hamburger menu and adds gesture recognizers
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        // set navigation items
            // set middle
            self.navigationItem.titleView = NavigationTitleLabel(withText: "Groups")
        
            // set left for groupViewController
//            self.setBackButtonImage()
        
            // set right
            let moreActionsImage = UIImage(named: "dotdotdot")?.withRenderingMode(.alwaysOriginal)
            let rightButtonItem = UIBarButtonItem.init(image: moreActionsImage, style: .plain, target: self, action: #selector(moreActionsClicked))
            self.navigationItem.rightBarButtonItem = rightButtonItem
        
            // format navigation bar
            self.removeNavigationBarUnderline()
        
        //initialize the table
        table.separatorInset = .zero
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
//        table.estimatedRowHeight = 90
//        table.rowHeight = UITableViewAutomaticDimension

//        self.initData()
        
//        //initializes the search bar
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        //navigationItem.searchController = searchController
//        searchBarView.addSubview(searchController.searchBar)
//        definesPresentationContext = true
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.searchBar.placeholder = "Search by name or username…"
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        searchController.searchBar.text = ""
        super.viewWillAppear(animated)
        self.initData()
        table.reloadData()
    }
//
//    //tells whether or not the user is currently using the search bar
//    func isSearching() -> Bool {
//        return searchController.isActive && !searchBarIsEmpty()
//    }
    
    //fills the people array with Person objects made from the csv file
    private func initData() {
        groups = [Group]()
        searchArray = [Group]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let username = appDelegate.myUser!.username
        
        searchArray += appDelegate.allData!.allGroups
        searchArray += appDelegate.allData!.searchGroups
        
        // MARK: TODO - Create re-usable function
        groups = searchArray.filter({ (group) in
            return appDelegate.allData!.isMemberOf(username: username, group: group)
        })
        
        searchArray = searchArray.sorted(by: groupKey)
        groups = groups.sorted(by: groupKey)
    }
    
    private func groupKey(one: Group, two:Group) -> Bool {
        return one.name.lowercased() < two.name.lowercased()
    }
    
    @objc private func moreActionsClicked() {
        print("more actions clicked")
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let newGroupButton = UIAlertAction(title: "New Group", style: .default, handler: { (action) -> Void in
            print("newGroupButton button tapped")
        })
        
        let sortByProfileButton = UIAlertAction(title: "Sort By Persona", style: .default, handler: { (action) -> Void in
            print("sortByProfileButton button tapped")
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        alertController.addAction(newGroupButton)
        alertController.addAction(sortByProfileButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }
    
}

//table extension
extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {
    //we have one section (for now) multiple would be initials of names
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //returns the number of rows to draw
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (isSearching()) {
//            return searchResults.count
//        } else {
            return groups.count
//        }
    }
    
    //makes rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let baseCell = table.dequeueReusableCell(withIdentifier: GroupTableCell.reuseIdentifier) else {
            return UITableViewCell()
        }
        let newCell = baseCell as! GroupTableCell
//        if (isSearching()) {
//            newCell.group = searchResults[indexPath.row]
//            if (appDelegate.allData?.isMemberOf(username: (appDelegate.myUser?.username)!, group: newCell.group!))! {
//                newCell.displayAsMember = true
//            } else {
//                newCell.displayAsMember = false
//            }
//        } else {
            newCell.group = groups[indexPath.row]
            newCell.displayAsMember = false
//        }
        newCell.update()
        return newCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat = 42   // Bio Label y value
        let text: NSString = groups[indexPath.row].bio as NSString
        let font: UIFont = UIFont(name: "Avenir-Roman", size: 14.0)!
        let constraintSize: CGSize = CGSize(width: 250.0, height: CGFloat.greatestFiniteMagnitude)
        let size: CGRect = text.boundingRect(with: constraintSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: font], context: nil)
        cellHeight += (size.height > 19.124 ? (19.124 * 2.0) : 19.124) + 15; //you can also add a cell padding if you want some space below textView
        print(cellHeight)

        return cellHeight
    }
    
    //when a row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var group: Group? = nil
//        if (isSearching()) {
//            group = searchResults[indexPath.row]
//        } else {
            group = groups[indexPath.row]
//        }
//        guard let groupView = self.storyboard?.instantiateViewController(withIdentifier: GroupViewController.storyboardID) as? GroupViewController else {
//            return
//        }
//        groupView.group = group
        
        guard group != nil, let groupView = self.storyboard?.instantiateViewController(withIdentifier: GroupViewController.storyboardID) as? GroupViewController else {
            return
        }
        groupView.setInfo(for: group!)
        self.navigationController?.pushViewController(groupView, animated: true)
    }
    
    
}
//
////search extension
//extension GroupsViewController: UISearchResultsUpdating {
//    // MARK: - UISearchResultsUpdating Delegate
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
//    }
//
//    func searchBarIsEmpty() -> Bool {
//        // Returns true if the text is empty or nil
//        return searchController.searchBar.text?.isEmpty ?? true
//    }
//
//    //actual filter function
//    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//        searchResults = searchArray.filter({( group : Group) -> Bool in
//            return ( group.name.lowercased().contains(searchText.lowercased()) || group.bio.lowercased().contains(searchText.lowercased()) )
//        })
//
//        table.reloadData()
//    }
//}

