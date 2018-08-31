//
//  ContactTableCell.swift
//  Fleet Sandbox
//
//  Created by Ryan Selden on 11/1/17.
//  Copyright © 2017 Ryan Selden. All rights reserved.
//

import Foundation
import UIKit

class NotificationTableCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    static let reuseIdentifier = "NotificationTableCell"
    static let nib: UINib = UINib(nibName: "NotificationTableCell", bundle: nil)
    
    var notification: Notification?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layoutMargins = .zero
        self.separatorInset = .zero
        self.selectionStyle = .none
        
        update()
    }
    
    public func update() {
        guard let notification = self.notification else {
            return
        }
        photo.image = UIImage(named: (notification.photo_key)!)
        photo.circleBorder(withCornerRadius: photo.bounds.size.width/2)

        //photo.contentMode = .scaleAspectFit
        
        timeLabel.text = notification.timeString

//        mainText.text = notification.mainText
        
        if let person = notification.person {
            guard let boldedFont = UIFont(name: "Avenir-Black", size: 16) else {
                mainText.text = notification.username! + " just joined fleet!"
                return
            }
            
            let formattedText = NSMutableAttributedString()
            formattedText.append(NSAttributedString(string: person.name, attributes: [.font: boldedFont]))
            formattedText.append(NSAttributedString(string: notification.mainText, attributes: [:]))
            formattedText.append(NSAttributedString(string: notification.platform, attributes: [.font: boldedFont]))
            mainText.attributedText = formattedText
        } else {
            mainText.text = notification.username! + " just joined fleet!"
        }
    }
}



