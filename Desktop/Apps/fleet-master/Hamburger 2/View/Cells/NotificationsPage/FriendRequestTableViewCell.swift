//
//  FriendRequestTableViewCell.swift
//  Hamburger 2
//
//  Created by Joann Lin on 5/24/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

class FriendRequestTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let storyboardID = "FriendRequestTableViewCell"
    static let reuseIdentifier = "FriendRequestTableViewCell"
    let imgSize: CGFloat = 30.0
    let buttonHeight: CGFloat = 27
    var requestingFriend: Person?
    var onClick: (() -> Void)?
    var clickedAccept: (() -> Void)?
    var clickedDecline: (() -> Void)?

    // MARK: - IBOutlets
    @IBOutlet weak var requestingFriendImageView: UIImageView!
    @IBOutlet weak var requestingFriendNameLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        // Initialization code
        requestingFriendImageView.circleBorder(withCornerRadius: requestingFriendImageView.bounds.size.width/2)
        acceptButton.circleBorder(withCornerRadius: (acceptButton.bounds.height / 2.0))
        rejectButton.circleBorder(withCornerRadius: (rejectButton.bounds.height / 2.0))
        
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellClicked)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func hideButtons() {
        acceptButton.isHidden = true
        rejectButton.isHidden = true
    }
    
    // MARK: - Initialization
    func setInfo(for requester: Person) {
        if let imgName = requester.photo_key {
            requestingFriendImageView.image = UIImage(named: imgName)
        }
        requestingFriendNameLabel.text = requester.name
    }

    // MARK: - IBActions
    @IBAction func acceptPressed(_ sender: Any) {
        print("debug: pressed accept")
        self.clickedAccept?()
    }
    @IBAction func rejectPressed(_ sender: Any) {
        print("debug: pressed reject")
        self.clickedDecline?()
    }
    
    @objc func cellClicked() {
        onClick?()
    }
}
