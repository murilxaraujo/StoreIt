//
//  StorageFileAttachment.swift
//  StoreIt
//
//  Created by Murilo Araujo on 19/02/24.
//  Copyright © 2024 M O DE ARAUJO TECNOLOGIA DA INFORMACAO LTDA. All rights reserved.
//

import Foundation
import CloudKit

struct StorageFileAttachment {
    var recordID: CKRecord.ID?
    var name: String
    var format: String
    var url: URL
    var owner: CKRecord.Reference
}
