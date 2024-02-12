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
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
