//
//  StorageLocation.swift
//  StoreIt
//
//  Created by Murilo Araujo on 21/02/24.
//  Copyright © 2024 M O DE ARAUJO TECNOLOGIA DA INFORMACAO LTDA. All rights reserved.
//

import Foundation
import CloudKit

struct StorageLocation {
    var recordID: CKRecord.ID?
    var name: String
    var parentLocation: CKRecord.Reference?
}
