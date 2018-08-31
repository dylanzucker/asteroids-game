//
//  GroupContactViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 11/13/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit

class GroupContactTableViewController: UITableViewController {
    
    // MARK: - Properties
    static let storyboardID = "GroupContactTableViewController"
    var contactInfo: [Info] = []
    
    // MARK: - Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.separatorStyle = .none
        self.tableView.separatorInset = .zero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension GroupContactTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //returns the number of rows to draw
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.reuseIdentifier, for: indexPath) as? InfoTableViewCell else {
            fatalError("The dequeued cell is not an instance of InfoTableViewCell.")
        }
        
        let info = contactInfo[indexPath.row]
        cell.setInfo(for: info)
        
        if (info.infoType == .email || info.infoType == .phoneNumber) {
            cell.hideConnectButton()
            //                cell.addBottomSpace()
        }
        
        if (info.infoType == .email || info.infoType == .phoneNumber) {
            cell.hideConnectButton()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
        //return UITableViewAutomaticDimension
    }
    
}
