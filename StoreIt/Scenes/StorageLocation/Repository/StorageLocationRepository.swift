//
//  StorageLocationRepository.swift
//  StoreIt
//
//  Created by Murilo Araujo on 21/02/24.
//  Copyright © 2024 M O DE ARAUJO TECNOLOGIA DA INFORMACAO LTDA. All rights reserved.
//

import Foundation
import CloudKit

protocol StorageLocationRepository {
    func add(item: StorageLocation) async throws
    func fetchItems() async throws -> [StorageLocation]
}

final class StorageLocationCloudKitRepository: StorageLocationRepository {
    
    private let db: CKDatabase
    
    init(db: CKDatabase) {
        self.db = db
    }
    
    func add(item: StorageLocation) async throws {
        let record = createRecord(from: item)
        try await db.save(record)
    }
    
    func fetchItems() async throws -> [StorageLocation] {
        let predicate = NSPredicate(value: true) // Fetch all records
        let query = CKQuery(recordType: LocationKeys.type.rawValue, predicate: predicate)
        
        let result = try await db.records(matching: query)
        
        return result.matchResults.compactMap { result in
            guard let record = try? result.1.get() else { return nil }
            return createStorageLocation(from: record)
        }
    }
    
    private func createRecord(from item: StorageLocation) -> CKRecord {
        let record = CKRecord(recordType: LocationKeys.type.rawValue)
        record[LocationKeys.name.rawValue] = item.name
        if let parentLocation = item.parentLocation {
            record[LocationKeys.parentLocation.rawValue] = parentLocation
        }
        
        return record
    }
    
    private func createStorageLocation(from record: CKRecord) -> StorageLocation? {
        guard let name = record[LocationKeys.name.rawValue] as? String else {
            return nil
        }
        
        let parentLocation = record[LocationKeys.parentLocation.rawValue] as? CKRecord.Reference
        
        return StorageLocation(recordID: record.recordID,
                               name: name,
                               parentLocation: parentLocation)
    }
}

extension StorageLocationCloudKitRepository {
    private enum LocationKeys: String {
        case type = "StorageLocation"
        case name, parentLocation
    }
}
