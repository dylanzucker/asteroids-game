//
//  MenuViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 5/30/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    // MARK: - Properties
    static let storyboardID = "MenuViewController"
    
    // MARK: - Outlets
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var menuTableViewHeight: NSLayoutConstraint!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapped)))
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Menu
    
    func setMenuHeight(with numRows: Int, ofHeight heightRows: CGFloat) {
        let height = CGFloat(numRows) * heightRows
        menuTableViewHeight.constant = height
//        menuTableView.layoutIfNeeded()
    }
    
    
}
