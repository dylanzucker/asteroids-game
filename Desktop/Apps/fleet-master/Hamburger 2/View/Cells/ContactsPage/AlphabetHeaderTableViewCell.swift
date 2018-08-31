//
//  AlphabetHeaderTableViewCell.swift
//  Hamburger 2
//
//  Created by Joann Lin on 5/22/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

class AlphabetHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var alphabetLabel: UILabel!
    static let reuseIdentifier = "AlphabetHeaderTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        alphabetLabel.textColor = Constants.Colors.themeColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLetter(to letter: String) {
        alphabetLabel.attributedText = NSAttributedString(string: letter, attributes: [NSAttributedStringKey.underlineColor: UIColor.lightGray, NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
    }

}
