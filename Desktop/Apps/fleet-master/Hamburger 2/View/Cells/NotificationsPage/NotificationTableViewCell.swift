//
//  NotificationTableViewCell.swift
//  Hamburger 2
//
//  Created by Joann Lin on 5/24/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let storyboardID = "NotificationTableViewCell"
    static let reuseIdentifier = "NotificationTableViewCell"
    let imgSize: CGFloat = 30.0
    var notification: Notification?
    
    // MARK: - IBOutlets
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layoutMargins = .zero
        self.separatorInset = .zero
        self.selectionStyle = .none
                
        personImageView.circleBorder(withCornerRadius: personImageView.bounds.width / 2.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Initialization
    func setInfo(for notification: Notification) {
        self.notification = notification
        
        if let person = notification.person, let imgName = person.photo_key {
            personImageView.image = UIImage(named: imgName)
            
            let formattedText = NSMutableAttributedString()
            formattedText.append(NSAttributedString(string: person.name, attributes: [.font: UIFont(name: "Avenir-Medium", size: 16) ?? UIFont.boldSystemFont(ofSize: 16)]))
            formattedText.append(NSAttributedString(string: notification.mainText, attributes: [.font: UIFont(name: "Avenir-Roman", size: 16) ?? UIFont.systemFont(ofSize: 16)]))
            formattedText.append(NSAttributedString(string: notification.platform, attributes: [.font: UIFont(name: "Avenir-Medium", size: 16) ?? UIFont.boldSystemFont(ofSize: 16)]))
            
            notificationLabel.attributedText = formattedText
            timeLabel.text = notification.timeString
        }
        
    }

}
