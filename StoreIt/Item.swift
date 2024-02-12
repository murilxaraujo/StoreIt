//
//  Item.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
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
