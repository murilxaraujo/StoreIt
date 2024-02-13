//
//  Router.swift
//  StoreIt
//
//  Created by Murilo Araujo on 13/02/24.
//

import SwiftUI

public final class Router: ObservableObject {
    @Published public var navPath = NavigationPath()
    public init() {}

    public func navigate(to destination: any Hashable) {
        navPath.append(destination)
    }

    public func navigateBack() {
        navPath.removeLast()
    }

    public func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
