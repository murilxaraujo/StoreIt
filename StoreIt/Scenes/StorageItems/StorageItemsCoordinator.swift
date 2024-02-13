//
//  StorageItemsCoordinator.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
//

import SwiftUI
import SwiftData

class StorageItemsCoordinator {
    enum Destinations {
        case addItem
    }
    
    let modelContext: ModelContext
    var router: Router
    lazy var repository = StorageItemRepository(modelContext: modelContext)
    
    init(modelContext: ModelContext, router: Router) {
        self.modelContext = modelContext
        self.router = router
    }
    
    @ViewBuilder
    func start() -> some View {
        let presenter = StorageItemsPresenter(repository: repository)
        StorageItemsView(presenter: presenter)
            .navigationDestination(for: Destinations.self) { [weak self] destination in
                switch destination {
                case .addItem:
                    self?.startAddStorageItem()
                }
            }
    }
    
    @ViewBuilder
    private func startAddStorageItem() -> some View {
        let presenter = AddStorageItemPresenter(repository: repository, delegate: self)
        AddStorageItemView(presenter: presenter)
    }
}

extension StorageItemsCoordinator: AddStoragePresenterDelegate {
    func didAddItem() {
        router.navigateBack()
    }
}
