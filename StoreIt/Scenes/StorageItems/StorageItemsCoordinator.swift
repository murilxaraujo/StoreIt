//
//  StorageItemsCoordinator.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
//

import SwiftUI
import SwiftData

struct StorageItemsCoordinator {
    let modelContext: ModelContext
    
    enum Destinations {
        case addItem
    }
    
    @ViewBuilder
    func start() -> some View {
        StorageItemsView()
            .navigationDestination(for: Destinations.self) { destination in
                switch destination {
                case .addItem:
                    startAddStorageItem()
                }
            }
    }
    
    @ViewBuilder
    private func startAddStorageItem() -> some View {
        let repository = StorageItemRepository(modelContext: modelContext)
        let presenter = AddStorageItemPresenter(repository: repository)
        AddStorageItemView(presenter: presenter)
    }
}
