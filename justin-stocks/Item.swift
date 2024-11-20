//
//  Item.swift
//  justin-stocks
//
//  Created by Justin Maronde on 11/20/24.
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
