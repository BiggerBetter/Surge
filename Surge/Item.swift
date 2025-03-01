//
//  Item.swift
//  Surge
//
//  Created by Jiong on 2025/3/1.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
