//
//  StorageFileAttachmentService.swift
//  StoreIt
//
//  Created by Murilo Araujo on 19/02/24.
//  Copyright © 2024 M O DE ARAUJO TECNOLOGIA DA INFORMACAO LTDA. All rights reserved.
//

import Foundation
import CloudKit

protocol StorageFileAttachmentRepository {
    func add(item: StorageFileAttachment) async throws
    func fetchItems(for ownerID: CKRecord.ID) async throws -> [StorageFileAttachment]
}

final class StorageFileAttachmentCloudKitRepository: StorageFileAttachmentRepository {
    
    private let db: CKDatabase
    
    init(db: CKDatabase) {
        self.db = db
    }
    
    func add(item: StorageFileAttachment) async throws {
        let record = createRecord(from: item)
        try await db.save(record)
    }
    
    func fetchItems(for ownerID: CKRecord.ID) async throws -> [StorageFileAttachment] {
        let predicate = NSPredicate(format: "owner == %@", CKRecord.Reference(recordID: ownerID, action: .none))
        let query = CKQuery(recordType: FileAttachmentKeys.type.rawValue, predicate: predicate)
        
        let result = try await db.records(matching: query)
        
        return result.matchResults.compactMap { result in
            guard let record = try? result.1.get() else { return nil }
            return createFileAttachment(from: record)
        }
    }
    
    private func createRecord(from item: StorageFileAttachment) -> CKRecord {
        let record = CKRecord(recordType: FileAttachmentKeys.type.rawValue)
        record[FileAttachmentKeys.name.rawValue] = item.name
        record[FileAttachmentKeys.format.rawValue] = item.format
        record[FileAttachmentKeys.file.rawValue] = CKAsset(fileURL: item.url)
        record[FileAttachmentKeys.owner.rawValue] = item.owner
        
        return record
    }
    
    private func createFileAttachment(from record: CKRecord) -> StorageFileAttachment? {
        guard let name = record[FileAttachmentKeys.name.rawValue] as? String,
              let format = record[FileAttachmentKeys.format.rawValue] as? String,
              let fileAsset = record[FileAttachmentKeys.file.rawValue] as? CKAsset,
              let url = fileAsset.fileURL,
              let owner = record[FileAttachmentKeys.owner.rawValue] as? CKRecord.Reference else {
            return nil
        }
        
        return StorageFileAttachment(recordID: record.recordID,
                                     name: name,
                                     format: format,
                                     url: url,
                                     owner: owner)
    }
}

extension StorageFileAttachmentCloudKitRepository {
    private enum FileAttachmentKeys: String {
        case type = "StorageFileAttachment"
        case name, format, file, owner
    }
}
