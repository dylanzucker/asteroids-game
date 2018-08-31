//
//  NavigationTitleLabel.swift
//  Hamburger 2
//
//  Created by Joann Lin on 11/25/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit

class NavigationTitleLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(withText text: String) {
        super.init(frame: CGRect.zero)
        self.font = UIFont.init(name: "Avenir Book", size: 16.0)
        self.text = text
    }

}
