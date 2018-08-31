//
//  ContactsViewController2.swift
//  
//
//  Created by Joann Lin on 5/22/18.
//

import UIKit
import HMSegmentedControl

enum ContactsPages: Int {
    case contacts, groups
}

class ContactsViewController: UIViewController {

    // MARK: - Properties
    static let storyboardID = "ContactsViewController"
    let searchController = UISearchController(searchResultsController: nil)
    var page: ContactsPages = .contacts
    var contactsPageViewController: ContactsPageViewController?

    // MARK: - IBOutlets
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var segmentedControl: HMSegmentedControl!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabViewSettings()
        
        // Search bar set-up
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        //navigationItem.searchController = searchController
        searchBarView.addSubview(searchController.searchBar)
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search by name or username…"

        // Segmented control set-up
        guard let segmentedControl = self.segmentedControl else {
            return
        }
//        segmentedControl.setBottomBorder()
        
        // Set title
        segmentedControl.sectionTitles = ["Contacts", "Groups"]
        segmentedControl.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Avenir-Heavy", size: 16)!, kCTForegroundColorAttributeName : UIColor.black]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Avenir-Heavy", size: 16)!, kCTForegroundColorAttributeName : Constants.Colors.themeColor]
        
        // Set bottom indicator
        segmentedControl.selectionIndicatorHeight = 5
        segmentedControl.selectionIndicatorColor = Constants.Colors.themeUnderlineColor
        segmentedControl.selectionIndicatorLocation = .down
        segmentedControl.selectionStyle = .textWidthStripe
        segmentedControl.segmentWidthStyle = .fixed
        segmentedControl.selectedSegmentIndex = page.rawValue
        handleSegmentedControlIndexChange(toPageForIndex: page.rawValue)
        
        // Set edge insets
        segmentedControl.segmentEdgeInset = UIEdgeInsets.zero
        segmentedControl.enlargeEdgeInset = UIEdgeInsets.zero
        
        // Set user interaction
        segmentedControl.isUserInteractionEnabled = true
        segmentedControl.indexChangeBlock = { [unowned self] index in
            self.handleSegmentedControlIndexChange(toPageForIndex: index)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide nav bar
        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // reset search
        searchController.searchBar.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        contactsPageViewController = segue.destination as? ContactsPageViewController
    }
    
    // MARK: - User Actions
    func handleSegmentedControlIndexChange(toPageForIndex index: Int) {
        if (index != page.rawValue) {
            guard let contactsPageViewController = contactsPageViewController else {
                return
            }
            page = ContactsPages(rawValue: index)!
            contactsPageViewController.adjust(toPage: page)
        }
    }
    
    // MARK: - Helper Functions
    //tells whether or not the user is currently using the search bar
    func isSearching() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

}

// MARK: - UISearchResultsUpdating Delegate
extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
//        self.table.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    //actual filter function
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//        searchResults = searchArray.filter({( person : Person) -> Bool in
//            let a = (person.name.lowercased().contains(searchText.lowercased()))
//            let b = person.username.lowercased().contains(searchText.lowercased())
//            return (a || b)
//        })
//
//        table.reloadData()
    }
}
