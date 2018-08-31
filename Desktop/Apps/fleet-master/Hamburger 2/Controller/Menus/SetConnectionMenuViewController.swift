//
//  SetConnectionMenuViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 6/23/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

// RYAN
// - set profiles (in viewWillAppear)
// - set current user (in viewWillAppear)
// - set friender (in AllFriendRequestsViewController)

class SetConnectionMenuViewController: UIViewController {
    
    static let storyboardID = "SetConnectionMenuViewController"

    @IBOutlet weak var connectionMenuTableView: UITableView!
    var profiles: [String] = [String]()
    var foreignUser: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // transparent background
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        connectionMenuTableView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        // table set-up
        connectionMenuTableView.delegate = self
        connectionMenuTableView.dataSource = self
        connectionMenuTableView.separatorStyle = .none
        connectionMenuTableView.layer.borderWidth = 1
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // RYAN - pull currentuser/# profiles
        // data set-up
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let currentUser = appDelegate.myUser else {
            return
        }
        
        profiles = currentUser.profiles
        connectionMenuTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SetConnectionMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // add 2 for header and footer cell
        // add profiles.count for # existing profiles
        // add 1 more for custom profile button
        // add 2 for top and bottom buffer cells
        return 2 + profiles.count + 1 + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
          // first row - header
        if (indexPath.row == 0 || indexPath.row == (profiles.count + 5 - 1)) {
            let cell = UITableViewCell()
            return cell
        }
        else if(indexPath.row == 1) {
            guard let cell = connectionMenuTableView.dequeueReusableCell(withIdentifier: ConnectionMenuHeaderTableViewCell.reuseIdentifier) as? ConnectionMenuHeaderTableViewCell else {
                return UITableViewCell()
            }
            
            if let foreignUser = foreignUser {
                cell.setName(to: foreignUser.firstName)
            }
            
            return cell
            
        } // second to last row - footer
        else if (indexPath.row == (profiles.count + 5 - 2)) {
            guard let cell = connectionMenuTableView.dequeueReusableCell(withIdentifier: "ConnectionMenuFooterCell") else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        } // middle row - connection cell
        else {
            guard let cell = connectionMenuTableView.dequeueReusableCell(withIdentifier: ConnectionMenuTableViewCell.reuseIdentifier) as? ConnectionMenuTableViewCell else {
                return UITableViewCell()
            }

            // 3rd to last row - Custom button
            if (indexPath.row == (profiles.count + 5 - 3)) {
                cell.setButtonText(to: "Custom")
            } else {
                cell.setButtonText(to: profiles[indexPath.row - 2])
                cell.setButtonBackground(to: Constants.Colors.InfoColors.twitchGradient)
            }
            return cell
        }        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0 || indexPath.row == (profiles.count + 5 - 1)) {
            let cellsHeight: CGFloat = (40.0 * 2.0) + ((CGFloat(profiles.count + 1)) * 80.0)
            let bufferCellHeight =  (self.view.frame.height - cellsHeight)/2
            return bufferCellHeight >= 0 ? bufferCellHeight : 0
        } else if (indexPath.row == 1 || indexPath.row == (profiles.count + 5 - 2)) {
            return 40.0
        } else {
            return 80.0   // default for header/footer
        }
    }
    
    
}
