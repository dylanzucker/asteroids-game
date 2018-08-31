//
//  TabBarController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 5/21/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    static let storyboardID = "TabBarController"

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.setBackButtonBackgroundImage(UIImage(named: "back_arrow"), for: .normal, barMetrics: .default)
        self.navigationItem.backBarButtonItem = backItem
    }


}
