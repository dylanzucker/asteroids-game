//
//  UIView.swift
//  Hamburger 2
//
//  Created by Joann Lin on 11/13/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import Foundation

extension UIView {
    func setBottomBorder(withThickness thickness: CGFloat) {
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.27).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: thickness)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func removeBottomBorder() {
//        self.layer.backgroundColor = UIColor.white.cgColor
//        
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.27).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowRadius = 0.0
    }
    
    func circleBorder(withCornerRadius cornerRadius: CGFloat) {
        self.layer.cornerRadius = (cornerRadius)
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }

}
