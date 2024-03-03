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
    @Inject var repository: StorageItemRepository
    @Inject var keyValueStore: KeyValueStore
    weak var delegate: AddStoragePresenterDelegate?
    
    @Published var state: AddStorageItemState = .idle
    @Published var itemImage: Data?
    @Published var itemName = String()
    @Published var itemDescription = String()
    @Published var pucharseDate: Date?
    @Published var itemNumber: Int = 0

    init(delegate: AddStoragePresenterDelegate) {
        self.delegate = delegate
        
        getModelNumber()
    }
    
    func tappedSaveItem() {
        state = .loading
        Task {
            do {
                var item = StorageItem(tag: itemNumber, name: itemName)
                item.pucharseDate = pucharseDate
                item.itemDescription = itemDescription.isEmpty ? nil : itemDescription
                item.imageData = itemImage
                try await repository.add(item: item)
                keyValueStore.set(itemNumber, forKey: "currentTag")
                delegate?.didAddItem()
            } catch {
                state = .idle
            }
        }
    }
    
    private func getModelNumber() {
        Task {
            let currentTag = keyValueStore.object(forKey: "currentTag") as? Int
            if let currentTag = currentTag {
                itemNumber = currentTag + 1
            } else {
                itemNumber = 1
            }
        }
    }
}
