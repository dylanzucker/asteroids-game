//
//  ContactsViewController.swift
//  Hamburger 2
//
//  Created by Ryan Selden on 11/4/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit
import HMSegmentedControl

class PeopleViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Properties
    static let storyboardID = "PeopleViewController"
    
    //the list of contacts that filter through the current search
    var searchResults: [Person] = [Person]()
    //the list of people to search from
    var searchArray: [Person] = [Person]()
    
    var showingAlphabeticalHeaders: Bool = false
    var nonAlphabeticalContacts = [Person]()
    var alphabeticalContacts = [AlphabeticalContact]()
    
    struct AlphabeticalContact {
        var letter: String
        var contacts: [Person]
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize the tableView
        tableView.separatorStyle = .none
        tableView.separatorInset = .zero
        tableView.dataSource = self
        tableView.delegate = self
//        self.initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateContacts()
        tableView.reloadData()
    }
    
    // MARK: - Helper Functions
    func updateContacts() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let data = appDelegate.allData else {
            self.nonAlphabeticalContacts = [Person]()
            self.alphabeticalContacts = [AlphabeticalContact]()
            return
        }
        
        // Get all people
        let allPeople = data.allPeople
        
        // Get all connected people (contacts)
        var nonAlphabeticalContacts = [Person]()
        for person in allPeople {
            if (data.isConnectedToMe(username: person.username)) {
                nonAlphabeticalContacts.append(person)
            }
        }
        
        showingAlphabeticalHeaders = nonAlphabeticalContacts.count >= Constants.AppSettings.minNumberPeopleForAlphabeticalHeaders

        if (showingAlphabeticalHeaders) {
            // Group connected people by first letter of first name
            var groupedContacts = [Character: [Person]]()
            
            for person in nonAlphabeticalContacts {
                
                let name = person.name
                
                if groupedContacts[name[name.startIndex]] == nil {
                    groupedContacts[name[name.startIndex]] = [Person]()
                }
                
                groupedContacts[name[name.startIndex]]!.append(person)
            }
            
            // Sort letters alphabetically
            let sortedLetters = Array(groupedContacts.keys).sorted(by: <)
            
            // Add letters-people and sort people alphabetically
            var alphabeticalContacts = [AlphabeticalContact]()
            for letter in sortedLetters {
                alphabeticalContacts.append(AlphabeticalContact(letter: "\(letter)", contacts: groupedContacts[letter]!.sorted(by: {($0.lastName, $0.firstName) < ($1.lastName, $1.firstName)} )))
            }
            
            self.alphabeticalContacts = alphabeticalContacts
        } else {
            self.nonAlphabeticalContacts = nonAlphabeticalContacts
        }
    }
}



// MARK: - UITableViewExtension
extension PeopleViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return showingAlphabeticalHeaders ? alphabeticalContacts.count : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showingAlphabeticalHeaders ? alphabeticalContacts[section].contacts.count + 1 : nonAlphabeticalContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (showingAlphabeticalHeaders) {
            if (indexPath.row == 0) {
                guard let alphabetHeaderCell = tableView.dequeueReusableCell(withIdentifier: AlphabetHeaderTableViewCell.reuseIdentifier) as? AlphabetHeaderTableViewCell else {
                    return UITableViewCell()
                }
                alphabetHeaderCell.setLetter(to: alphabeticalContacts[indexPath.section].letter)
                return alphabetHeaderCell
            } else {
                return getCellForPerson(alphabeticalContacts[indexPath.section].contacts[indexPath.row - 1])
            }
        } else {
            return getCellForPerson(nonAlphabeticalContacts[indexPath.row])
        }
        
//        if (isSearching()) {
//            guard let baseCell = tableView.dequeueReusableCell(withIdentifier: ContactTableSearchCell.reuseIdentifier) as? ContactTableSearchCell else {
//                return UITableViewCell()
//            }
//
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//            baseCell.displayConnected = true
//            baseCell.person = searchResults[indexPath.row]
//            if (appDelegate.allData?.isConnectedToMe(username: (baseCell.person?.username)!))! {
//                baseCell.isConnected = true
//            } else {
//                baseCell.isConnected = false
//            }
//            baseCell.update()
//
//            return baseCell
//        } else {
        
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath) as? ContactTableCell) != nil,
            let tabController = self.tabBarController,
            let navController = tabController.navigationController {
            goToProfile(of: showingAlphabeticalHeaders ? alphabeticalContacts[indexPath.section].contacts[indexPath.row - 1] : nonAlphabeticalContacts[indexPath.row], using: navController)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.cellForRow(at: indexPath) as? AlphabetHeaderTableViewCell != nil {
            return 25.0
        }

        if tableView.cellForRow(at: indexPath) as? ContactTableCell != nil {
            return 50.0
        }
        
        return UITableViewAutomaticDimension
    }
    
    private func getCellForPerson(_ person: Person) -> UITableViewCell {
        guard let personCell = tableView.dequeueReusableCell(withIdentifier: ContactTableCell.reuseIdentifier) as? ContactTableCell else {
            return UITableViewCell()
        }
        personCell.person = person
        personCell.update()
        return personCell
    }
}


