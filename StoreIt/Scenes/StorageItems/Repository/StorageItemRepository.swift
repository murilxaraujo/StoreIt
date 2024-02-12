//
//  StorageItemRepository.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
//

import Foundation
import SwiftData

class StorageItemRepository {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func add(item: StorageItem) {
        modelContext.insert(item)
    }
    
    func fetchItems() -> [StorageItem] {
        do {
            let descriptor = FetchDescriptor<StorageItem>(sortBy: [SortDescriptor(\.id, order: .reverse)])
            return try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
            return []
        }
    }
}
