//
//  AddStorageItemPresenter.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
//

import Foundation

class AddStorageItemPresenter: ObservableObject {
    let repository: StorageItemRepository
    
    @Published var itemImage: Data?
    @Published var itemName = String()

    init(repository: StorageItemRepository) {
        self.repository = repository
    }
    
    func tappedSaveItem() {
        
    }
}
