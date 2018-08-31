//
//  MenuTableViewCell.swift
//  Hamburger 2
//
//  Created by Joann Lin on 5/30/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MenuTableViewCell"
    @IBOutlet weak var menuLabel: UILabel!
    var onClick: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellClicked)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabelText(to text: String) {
        menuLabel.text = text
    }
    
    func setTextStyle(to styleNum: Int) {
        switch(styleNum) {
        case 0:
            menuLabel.font = UIFont(name: "Avenir-Medium", size: 16)
        case 1:
            menuLabel.font = UIFont(name: "Avenir-Roman", size: 16)
        case 2:
            menuLabel.font = UIFont(name: "Avenir-Heavy", size: 16)
        default:
            menuLabel.font = UIFont(name: "Avenir-Medium", size: 16)
        }
    }
    
    @objc func cellClicked() {
        onClick?()
    }


}
