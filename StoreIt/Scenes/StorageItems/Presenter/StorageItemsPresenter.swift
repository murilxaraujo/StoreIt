//
//  StorageItemsPresenter.swift
//  StoreIt
//
//  Created by Murilo Araujo on 13/02/24.
//

import Foundation

protocol StorageItemsPresenterType: ObservableObject {
    var items: [StorageItem] { get set }
}

class StorageItemsPresenter: StorageItemsPresenterType {
    let repository: StorageItemRepository
    @Published var items: [StorageItem] = []
    
    init(repository: StorageItemRepository) {
        self.repository = repository
        getItems()
    }
    
    func getItems() {
        items = repository.fetchItems()
    }
}
