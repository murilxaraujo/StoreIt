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
        let record = createRecord(from: item)
        try await db.save(record)
    }
    
    func fetchItems() async throws -> [StorageItem] {
        let query = CKQuery(recordType: StorageItemKeys.type.rawValue, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: StorageItemKeys.tag.rawValue, ascending: false)]
        let result = try await db.records(matching: query)
        
        return result.matchResults.compactMap { result in
            guard let record = try? result.1.get() else { return nil }
            return createStorageItem(from: record)
        }
    }
    
    private func createRecord(from item: StorageItem) -> CKRecord {
        let record = CKRecord(recordType: StorageItemKeys.type.rawValue)
        record[StorageItemKeys.tag.rawValue] = item.tag
        record[StorageItemKeys.name.rawValue] = item.name
        record[StorageItemKeys.itemDescription.rawValue] = item.itemDescription
        record[StorageItemKeys.pucharseDate.rawValue] = item.pucharseDate
        
        if let imageData = item.imageData, let url = fileService.cache(imageData, forID: UUID()) {
            record[StorageItemKeys.image.rawValue] = CKAsset(fileURL: url)
        }
        
        return record
    }
    
    private func createStorageItem(from record: CKRecord) -> StorageItem? {
        guard let tag = record[StorageItemKeys.tag.rawValue] as? Int,
              let name = record[StorageItemKeys.name.rawValue] as? String else {
            return nil
        }
        
        let itemDescription = record[StorageItemKeys.itemDescription.rawValue] as? String
        let pucharseDate = record[StorageItemKeys.pucharseDate.rawValue] as? Date
        let imageData = (record[StorageItemKeys.image.rawValue] as? CKAsset)
            .flatMap { try? Data(contentsOf: $0.fileURL!) }
        
        return StorageItem(recordID: record.recordID,
                           tag: tag,
                           name: name,
                           itemDescription: itemDescription,
                           pucharseDate: pucharseDate,
                           imageData: imageData)
    }
}

extension StorageItemCloudKitRepository {
    private enum StorageItemKeys: String {
        case type = "StorageItem"
        case tag, name, itemDescription, pucharseDate, image
    }
}
