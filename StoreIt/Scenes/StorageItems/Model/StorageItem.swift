//
//  StorageItem.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
//

import Foundation
import CloudKit

struct StorageItem {
    var recordID: CKRecord.ID?
    var tag: Int
    var name: String
    var itemDescription: String?
    var pucharseDate: Date?
    var imageData: Data?
}
