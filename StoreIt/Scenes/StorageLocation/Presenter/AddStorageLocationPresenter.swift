//
//  AddStorageLocationPresenter.swift
//  StoreIt
//
//  Created by Murilo Araujo on 21/02/24.
//  Copyright © 2024 M O DE ARAUJO TECNOLOGIA DA INFORMACAO LTDA. All rights reserved.
//

import Foundation
import CloudKit

protocol AddStorageLocationPresenterType: ObservableObject {
    var locationName: String { get set }
    func addStorageLocation()
}

class AddStorageLocationPresenter: AddStorageLocationPresenterType {
    @Published var locationName: String = ""
    
    private var repository: StorageLocationRepository
    
    init(repository: StorageLocationRepository) {
        self.repository = repository
    }
    
    func addStorageLocation() {
        Task {
            do {
                let newLocation = StorageLocation(name: locationName, parentLocation: nil)
                try await repository.add(item: newLocation)
            } catch {
            }
        }
    }
}
