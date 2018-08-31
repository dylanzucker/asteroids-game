//
//  ContactTableCell.swift
//  Fleet Sandbox
//
//  Created by Ryan Selden on 11/1/17.
//  Copyright © 2017 Ryan Selden. All rights reserved.
//

import Foundation
import UIKit

class ContactTableSearchCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    static let reuseIdentifier = "ContactTableSearchCell"
    static let nib: UINib = UINib(nibName: "ContactTableSearchCell", bundle: nil)
    
    var person: Person?
    //isConnected changes the style and text, depending on whether this is a user's contact or a search result
    var isConnected: Bool?
    var displayConnected: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        update()
    }
    
    public func update() {
        if (nameLabel != nil && photo != nil && person != nil) {
            nameLabel.text = person?.name
            photo.image = UIImage(named: (person?.photo_key)!)
            
            photo.circleBorder(withCornerRadius: photo.bounds.size.width/2)

            if (displayConnected) {
                if (isConnected)! {
                    usernameLabel.text = "You're connected with @"+(person?.username)!
                    nameLabel.font = UIFont(name: "Avenir-Black", size: 19)
                } else {
                    usernameLabel.text = "@"+(person?.username)!
                    nameLabel.font = UIFont(name: "Avenir-Roman", size: 19)
                }
            }
        }
    }
}

