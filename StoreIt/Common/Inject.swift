//
//  Inject.swift
//  StoreIt
//
//  Created by Murilo Araujo on 17/02/24.
//  Copyright © 2024 M O DE ARAUJO TECNOLOGIA DA INFORMACAO LTDA. All rights reserved.
//

import Foundation
import Swinject

extension Container {
    static var shared = Container()
    subscript<T>(type: T.Type) -> T {
        get { resolve(type)! }
    }
}

@propertyWrapper
struct Inject<T> {
    private let name: String?
    
    init(_ name: String? = nil) {
        self.name = name
    }
    
    var wrappedValue: T {
        get {
            let resolved = Container.shared.resolve(T.self, name: name)
            assert(resolved != nil, "Dependency not found: \(String(describing: T.self)) \(String(describing: name))")
            return resolved!
        }
    }
}
