//
//  KeyValueStoreMock.swift
//  StoreItTests
//
//  Created by Murilo Araujo on 18/02/24.
//  Copyright © 2024 M O DE ARAUJO TECNOLOGIA DA INFORMACAO LTDA. All rights reserved.
//

@testable import StoreIt

class MockKeyValueStore: KeyValueStore {
    var store = [String: Any]()
    
    func set(_ value: Any?, forKey defaultName: String) {
        store[defaultName] = value
    }
    
    func object(forKey defaultName: String) -> Any? {
        return store[defaultName]
    }
    
    func removeObject(forKey defaultName: String) {
        store.removeValue(forKey: defaultName)
    }
    
    func synchronize() -> Bool {
        return true
    }
}
