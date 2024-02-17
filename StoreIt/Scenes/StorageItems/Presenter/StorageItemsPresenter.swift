//
//  StorageItemsPresenter.swift
//  StoreIt
//
//  Created by Murilo Araujo on 13/02/24.
//

import Foundation

protocol StorageItemsPresenterType: ObservableObject {
    var items: [StorageItem] { get set }
    func getItems()
}

class StorageItemsPresenter: StorageItemsPresenterType {
    
    @Inject var repository: StorageItemRepository
    @Published var items: [StorageItem] = []
    
    func getItems() {
        Task {
            let itemsArray = try? await repository.fetchItems()
            items = itemsArray ?? []
        }
        
    }
}
