//
//  StoreItApp.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
//

import SwiftUI
import Swinject

@main
struct StoreItApp: App {
    @ObservedObject
    var router: Router
    
    let coordinator: StorageItemsCoordinator

    init() {
        Container.shared = DependenciesContainer.production
        let router = Router()
        self.router = router
        coordinator = StorageItemsCoordinator(router: router)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                coordinator.start()
            }
        }
    }
}
