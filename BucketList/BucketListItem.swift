//
//  BucketListItem.swift
//  BucketList
//
//  Created by Joe Durand on 10/13/16.
//  Copyright © 2016 Cal Poly App Dev. All rights reserved.
//

import Foundation

class BucketListItem {
    var name: String
    var timestamp: NSDate
    
    init(name: String, timestamp: NSDate) {
        self.name = name
        self.timestamp = timestamp
    }
}
