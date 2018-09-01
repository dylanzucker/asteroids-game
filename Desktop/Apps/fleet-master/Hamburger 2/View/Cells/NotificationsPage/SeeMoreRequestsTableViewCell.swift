//
//  SeeMoreRequestsTableViewCell.swift
//  Hamburger 2
//
//  Created by Joann Lin on 5/28/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

class SeeMoreRequestsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "SeeMoreRequestsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
