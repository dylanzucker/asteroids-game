//
//  CreateIDsTableViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 6/10/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

class CreateIDsTableViewController: UITableViewController {

    static let identifier = "CreateIDsTableViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorStyle = .none
        
        self.fixStatusBarBugSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setNavigationBar() {
        // set nav bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.removeNavigationBarUnderline()
//        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
        
        // middle nav item
        self.navigationItem.titleView = NavigationTitleLabel(withText: "")
        
        //  left nav item
        setBackButton()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch(indexPath.row) {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "CreateIDsHeaderTableViewCell", for: indexPath)
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CreateIDsTableViewCell.reuseIdentifier, for: indexPath) as? CreateIDsTableViewCell else {
                return UITableViewCell()
            }
            return cell
        default:
            return UITableViewCell()
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 
        if tableView.cellForRow(at: indexPath) as? CreateIDsTableViewCell != nil {
            return 85.0
        } else {
            return 95.0 // header
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
