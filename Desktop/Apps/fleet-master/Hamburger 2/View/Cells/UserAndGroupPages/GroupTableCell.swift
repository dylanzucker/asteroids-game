//
//  ContactTableCell.swift
//  Fleet Sandbox
//
//  Created by Ryan Selden on 11/1/17.
//  Copyright © 2017 Ryan Selden. All rights reserved.
//

import Foundation
import UIKit

class GroupTableCell: UITableViewCell {
    
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    static let reuseIdentifier = "GroupTableCell"
    static let nib: UINib = UINib(nibName: "GroupTableCell", bundle: nil)
    
    var group: Group?
    var displayAsMember: Bool? = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        update()
    }
    
    public func update() {
        if (nameLabel != nil && photo != nil && group != nil) {
            nameLabel.text = group?.name
            bioLabel.text = group?.bio
            photo.image = UIImage(named: (group?.photo_key)!)
            
            photo.circleBorder(withCornerRadius: photo.bounds.size.width/2)
            
            //photo.contentMode = .scaleAspectFit
            
            if (displayAsMember)! {
                nameLabel.font = UIFont(name: "Avenir-Black", size: 16)
            } else {
                nameLabel.font = UIFont(name: "Avenir-Roman", size: 16)
            }            
        }
    }
}


