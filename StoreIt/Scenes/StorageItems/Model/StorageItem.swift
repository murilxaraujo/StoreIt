//
//  StorageItem.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
//

import Foundation
import SwiftData

@Model
class StorageItem {
    let id: Int
    var name: String
    var itemDescription: String?
    var pucharseDate: Date?
    
    init(id: Int, name: String, itemDescription: String? = nil, pucharseDate: Date? = nil) {
        self.id = id
        self.name = name
        self.itemDescription = itemDescription
        self.pucharseDate = pucharseDate
    }
}
