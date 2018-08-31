//
//  InfoTableViewCell.swift
//  Hamburger 2
//
//  Created by Joann Lin on 11/13/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import Foundation

class InfoTableViewCell: UITableViewCell {
    static let reuseIdentifier = "InfoTableViewCell"
    static let nib: UINib = UINib(nibName: "InfoTableViewCell", bundle: nil)
    
    var info: Info?
    var isConnected: Bool = false
    
    @IBOutlet weak var infoBackground: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var connectButton: UIButton!
//    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
//    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        infoBackground.circleBorder(withCornerRadius: 5.0)
    }
    
    func setInfo(for info: Info) {
        self.info = info
        title.text = info.title
        information.text = info.information
        
        switch(info.infoType) {
        case .facebook:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.facebookGradient)
            setTextColorTo(color: Constants.Colors.TextColors.facebookTextColor)
            break
        case .instagram:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.instagramGradient)
            setTextColorTo(color: Constants.Colors.TextColors.instagramTextColor)
            break
        case .linkedin:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.linkedinGradient)
            setTextColorTo(color: Constants.Colors.TextColors.linkedinTextColor)
            break
        case .pinterest:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.pinterestGradient)
            setTextColorTo(color: Constants.Colors.TextColors.pinterestTextColor)
            break
        case .snapchat:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.snapchatGraident)
            setTextColorTo(color: Constants.Colors.TextColors.snapchatTextColor)
            break
        case .twitter:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.twitterGradient)
            setTextColorTo(color: Constants.Colors.TextColors.twitterTextColor)
            break
        case .youtube:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.youtubeGradient)
            setTextColorTo(color: Constants.Colors.TextColors.youtubeTextColor)
            break
        case .behance:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.behanceGradient)
            setTextColorTo(color: Constants.Colors.TextColors.behanceTextColor)
            break
        case .dribble:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.dribbleGradient)
            setTextColorTo(color: Constants.Colors.TextColors.dribbleTextColor)
            break
        case .flickr:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.flickrGradient)
            setTextColorTo(color: Constants.Colors.TextColors.flickrTextColor)
            break
        case .github:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.githubGradient)
            setTextColorTo(color: Constants.Colors.TextColors.githubTextColor)
            break
        case .googlePlus:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.googlePlusGradient)
            setTextColorTo(color: Constants.Colors.TextColors.googlePlusTextColor)
            break
        case .kik:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.kikGradient)
            setTextColorTo(color: Constants.Colors.TextColors.kikTextColor)
            break
        case .medium:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.mediumGradient)
            setTextColorTo(color: Constants.Colors.TextColors.mediumTextColor)
            break
        case .reddit:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.redditGradient)
            setTextColorTo(color: Constants.Colors.TextColors.redditTextColor)
            break
        case .skype:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.skypeGradient)
            setTextColorTo(color: Constants.Colors.TextColors.skypeTextColor)
            break
        case .soundcloud:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.soundcloudGradient)
            setTextColorTo(color: Constants.Colors.TextColors.soundcloudTextColor)
            break
        case .spotify:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.spotifyGradient)
            setTextColorTo(color: Constants.Colors.TextColors.spotifyTextColor)
            break
        case .tumblr:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.tumblrGradient)
            setTextColorTo(color: Constants.Colors.TextColors.tumblrTextColor)
            break
        case .twitch:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.twitchGradient)
            setTextColorTo(color: Constants.Colors.TextColors.twitchTextColor)
            break
        case .venmo:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.venmoGradient)
            setTextColorTo(color: Constants.Colors.TextColors.venmoTextColor)
            break
        case .weChat:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.weChatGradient)
            setTextColorTo(color: Constants.Colors.TextColors.weChatTextColor)
            break
        case .whatsApp:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.whatsAppGradient)
            setTextColorTo(color: Constants.Colors.TextColors.whatsAppTextColor)
            break
        case .yelp:
            setBackgroundTo(gradient: Constants.Colors.InfoColors.yelpGradient)
            setTextColorTo(color: Constants.Colors.TextColors.yelpTextColor)
            break
        default:
            //  captures email, website, phone number, and custom
            setBackgroundTo(gradient: Constants.Colors.InfoColors.defaultGradient)
            setTextColorTo(color: Constants.Colors.TextColors.defaultTextColor)
            break
        }
    }
    
    @IBAction func connectButtonPressed(_ sender: Any) {
        isConnected = !isConnected
        changeConnectButton()
    }
    
    func changeConnectButton() {
        if (isConnected) {
            connectButton.setImage(UIImage(named: "minus_button"), for: .normal)
        } else {
            connectButton.setImage(UIImage(named: "add_button"), for: .normal)
        }
    }
    
    func hideConnectButton() {
        connectButton.isUserInteractionEnabled = false
        connectButton.isHidden = true
    }
    
//    func addBottomSpace() {
//        self.topConstraint.constant = 15
//        self.bottomConstraint.constant = 20
//        self.layoutIfNeeded()
//        self.setBottomBorder()
//    }
    
    private func setBackgroundTo(color: UIColor) {
        infoBackground.backgroundColor = color
    }
    
    private func setTextColorTo(color: UIColor) {
        title.textColor = color
    }
    
    private func setBackgroundTo(gradient: CAGradientLayer) {
        infoBackground.backgroundColor = UIColor.clear
        let backgroundLayer = gradient
        backgroundLayer.frame = infoBackground.bounds
        infoBackground.layer.insertSublayer(backgroundLayer, at: 0)
    }
}
