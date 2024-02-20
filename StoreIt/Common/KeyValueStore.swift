//
//  KeyValueStore.swift
//  StoreIt
//
//  Created by Murilo Araujo on 18/02/24.
//  Copyright © 2024 M O DE ARAUJO TECNOLOGIA DA INFORMACAO LTDA. All rights reserved.
//

import Foundation

protocol KeyValueStore {
    func set(_ value: Any?, forKey defaultName: String)
    func object(forKey defaultName: String) -> Any?
    func removeObject(forKey defaultName: String)
    func synchronize() -> Bool
}

extension NSUbiquitousKeyValueStore: KeyValueStore {}
