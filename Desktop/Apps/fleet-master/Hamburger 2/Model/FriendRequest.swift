//
//  Request.swift
//  Hamburger 2
//
//  Created by Joann Lin on 5/25/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import Foundation

class FriendRequest {
    var friender: Person = Person()
    var friendee: Person = Person()
    
    init(friender: Person, friendee: Person) {
        self.friender = friender
        self.friendee = friendee
    }
}
