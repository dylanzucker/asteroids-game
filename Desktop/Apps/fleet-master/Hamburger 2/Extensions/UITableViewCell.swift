//
//  UITableViewCell.swift
//  Hamburger 2
//
//  Created by Joann Lin on 5/22/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import Foundation

extension UITableViewCell {
    func addBorder() {
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
}
