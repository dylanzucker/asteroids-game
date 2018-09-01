//
//  SettingsTableViewCell.swift
//  Hamburger 2
//
//  Created by Joann Lin on 11/26/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingName: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    
    static let reuseIdentifier = "SettingsTableViewCell"
    static let nib: UINib = UINib(nibName: "SettingsTableViewCell", bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
