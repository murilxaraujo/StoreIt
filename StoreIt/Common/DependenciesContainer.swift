//
//  DependenciesContainer.swift
//  StoreIt
//
//  Created by Murilo Araujo on 17/02/24.
//  Copyright © 2024 M O DE ARAUJO TECNOLOGIA DA INFORMACAO LTDA. All rights reserved.
//

import Foundation
import CloudKit
import Swinject

class DependenciesContainer {
    static let production: Container = {
        let dataBase = CKContainer.default().privateCloudDatabase
        let container = Container()
        container.register(StorageItemRepository.self) { _ in
            StorageItemCloudKitRepository(db: dataBase)
        }
        container.register(FileService.self) { _ in
            CacheFileService()
        }
        container.register(KeyValueStore.self) { _ in
            NSUbiquitousKeyValueStore.default
        }
        return container
    }()
}
