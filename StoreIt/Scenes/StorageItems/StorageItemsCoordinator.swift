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
    
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    @ViewBuilder
    func start() -> some View {
        let presenter = StorageItemsPresenter()
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
        let presenter = AddStorageItemPresenter(delegate: self)
        AddStorageItemView(presenter: presenter)
    }
}

extension StorageItemsCoordinator: AddStoragePresenterDelegate {
    func didAddItem() {
        router.navigateBack()
    }
}
