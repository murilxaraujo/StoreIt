//
//  StoreItApp.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
//

import SwiftUI
import SwiftData



@main
struct StoreItApp: App {
    var sharedModelContainer: ModelContainer
    @ObservedObject var router: Router
    let coordinator: StorageItemsCoordinator

    init() {
        let router = Router()
        sharedModelContainer = StoreItApp.createModelContainer()
        self.router = router
        coordinator = StorageItemsCoordinator(modelContext: sharedModelContainer.mainContext, router: router)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                coordinator.start()
            }
        }
    }
    
    static func createModelContainer() -> ModelContainer {
        let schema = Schema([
            StorageItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
