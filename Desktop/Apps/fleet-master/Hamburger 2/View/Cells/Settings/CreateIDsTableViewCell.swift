//
//  CreateIDsTableViewCell.swift
//  Hamburger 2
//
//  Created by Joann Lin on 6/10/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

class CreateIDsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "CreateIDsTableViewCell"
    @IBOutlet weak var idBackgroundView: UIView!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.idBackgroundView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
