//
//  ContactTableCell.swift
//  Fleet Sandbox
//
//  Created by Ryan Selden on 11/1/17.
//  Copyright © 2017 Ryan Selden. All rights reserved.
//

import Foundation
import UIKit

class GroupContactTableCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    static let reuseIdentifier = "GroupContactTableCell"
    static let nib: UINib = UINib(nibName: "GroupContactTableCell", bundle: nil)
    
    var person: Person?
    
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
            
        }
    }
}


