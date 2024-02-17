//
//  StorageItemRepository.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
//

import Foundation
import CloudKit

protocol StorageItemRepository {
    func add(item: StorageItem) async throws
    func fetchItems() async throws -> [StorageItem]
}

class StorageItemCloudKitRepository: StorageItemRepository {
    
    @Inject private var fileService: FileService
    private let db: CKDatabase
    
    init(db: CKDatabase) {
        self.db = db
    }
    
    func add(item: StorageItem) async throws {
        let record = CKRecord(recordType: StorageItemKeys.type.rawValue)
        record[StorageItemKeys.tag.rawValue] = item.tag
        record[StorageItemKeys.name.rawValue] = item.name
        record[StorageItemKeys.itemDescription.rawValue] = item.itemDescription
        record[StorageItemKeys.pucharseDate.rawValue] = item.pucharseDate
        
        if let imageData = item.imageData,
           let url = fileService.cache(imageData, forID: UUID()) {
            record[StorageItemKeys.image.rawValue] = CKAsset(fileURL: url)
        }
        
        try await db.save(record)
    }
    
    func fetchItems() async throws -> [StorageItem] {
        let query = CKQuery(recordType: StorageItemKeys.type.rawValue, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: StorageItemKeys.tag.rawValue, ascending: false)]
        let result = try await db.records(matching: query)
        let records = result.matchResults.compactMap { try? $0.1.get() }
        
        var storageItems = [StorageItem]()
        records.forEach { record in
            guard let tag = record[StorageItemKeys.tag.rawValue] as? Int,
                  let name = record[StorageItemKeys.name.rawValue] as? String else {
                return
            }
            let itemDescription = record[StorageItemKeys.itemDescription.rawValue] as? String
            let pucharseDate = record[StorageItemKeys.pucharseDate.rawValue] as? Date
            let imageRecord = record[StorageItemKeys.image.rawValue] as? CKAsset
            var imageData: Data?
            
            if let imageRecord = imageRecord,
               let imageUrl = imageRecord.fileURL,
               let data = try? Data(contentsOf: imageUrl) {
                imageData = data
            }
            
            let item = StorageItem(recordID: record.recordID,
                                   tag: tag,
                                   name: name,
                                   itemDescription: itemDescription,
                                   pucharseDate: pucharseDate,
                                   imageData: imageData)
            storageItems.append(item)
        }
        return storageItems
    }
}

extension StorageItemCloudKitRepository {
    private enum StorageItemKeys: String {
        case type = "StorageItem"
        case tag, name, itemDescription, pucharseDate, image
    }
}
