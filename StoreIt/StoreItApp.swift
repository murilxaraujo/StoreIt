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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            StorageItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StorageItemsCoordinator(modelContext: sharedModelContainer.mainContext)
                    .start()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
