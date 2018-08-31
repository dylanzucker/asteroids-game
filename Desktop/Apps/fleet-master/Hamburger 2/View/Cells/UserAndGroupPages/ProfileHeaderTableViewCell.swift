//
//  ProfileHeaderTableViewCell.swift
//  Hamburger 2
//
//  Created by Joann Lin on 4/24/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

class ProfileHeaderTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ProfileHeaderTableViewCell"
    static let nib: UINib = UINib(nibName: "ProfileHeaderTableViewCell", bundle: nil)
    var moreActionsClicked: (() -> ())?
    
    @IBAction func clickedMoreActionsButton(_ sender: Any) {
        moreActionsClicked?()
    }
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUsername(to username: String) {
        usernameLabel.text = "@" + username
    }
}
