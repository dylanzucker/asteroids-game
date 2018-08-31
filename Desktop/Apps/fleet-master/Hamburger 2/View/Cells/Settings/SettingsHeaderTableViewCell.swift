//
//  SettingsHeaderTableViewCell.swift
//  Hamburger 2
//
//  Created by Joann Lin on 11/26/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit

class SettingsHeaderTableViewCell: UITableViewCell {

    static let reuseIdentifier = "SettingsHeaderTableViewCell"
    
    @IBOutlet weak var settingsHeader: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
