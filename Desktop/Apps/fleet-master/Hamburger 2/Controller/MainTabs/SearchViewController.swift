//
//  SearchViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 4/24/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabViewSettings()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
