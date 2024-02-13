//
//  AddStorageItemPresenter.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
//

import Foundation

enum AddStorageItemState {
    case idle, loading
}

protocol AddStoragePresenterDelegate: AnyObject {
    func didAddItem()
}

protocol AddStorageItemPresenterType: AnyObject, ObservableObject {
    var state: AddStorageItemState { get set }
    var itemName: String { get set }
    var itemImage: Data? { get set }
    var itemDescription: String { get set }
    var pucharseDate: Date? { get set }
    var delegate: AddStoragePresenterDelegate? { get set }
    var itemNumber: Int { get }
    
    func tappedSaveItem()
}

class AddStorageItemPresenter: AddStorageItemPresenterType {
    let repository: StorageItemRepository
    weak var delegate: AddStoragePresenterDelegate?
    
    @Published var state: AddStorageItemState = .idle
    @Published var itemImage: Data?
    @Published var itemName = String()
    @Published var itemDescription = String()
    @Published var pucharseDate: Date?
    @Published var itemNumber: Int = 0

    init(repository: StorageItemRepository, delegate: AddStoragePresenterDelegate) {
        self.repository = repository
        self.delegate = delegate
        
        getModelNumber()
    }
    
    func tappedSaveItem() {
        state = .loading
        var item = StorageItem(id: itemNumber, name: itemName)
        item.pucharseDate = pucharseDate
        item.itemDescription = itemDescription.isEmpty ? nil : itemDescription
        
        repository.add(item: item)
        delegate?.didAddItem()
    }
    
    private func getModelNumber() {
        itemNumber = repository.fetchItems().count + 1
        
    }
}
