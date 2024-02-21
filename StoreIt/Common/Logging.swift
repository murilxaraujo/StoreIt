//
//  Logging.swift
//  StoreIt
//
//  Created by Murilo Araujo on 20/02/24.
//  Copyright © 2024 M O DE ARAUJO TECNOLOGIA DA INFORMACAO LTDA. All rights reserved.
//

import OSLog

extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")

    /// All logs related to tracking and analytics.
    static let statistics = Logger(subsystem: subsystem, category: "statistics")
    
    /// All logs related to repositories request
    static let repositories = Logger(subsystem: subsystem, category: "repository")
    
    static let fileService = Logger(subsystem: subsystem, category: "fileService")
}