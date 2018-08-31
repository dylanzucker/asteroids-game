//
//  Collection.swift
//  Hamburger 2
//
//  Created by Joann Lin on 5/22/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import Foundation

extension Collection  {
    func element(at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
