//
//  FileService.swift
//  StoreIt
//
//  Created by Murilo Araujo on 17/02/24.
//  Copyright © 2024 M O DE ARAUJO TECNOLOGIA DA INFORMACAO LTDA. All rights reserved.
//

import Foundation

protocol FileService {
    func cache(_ data: Data, forID id: UUID) -> URL?
    func clearCache()
}

class CacheFileService: FileService {
    private var cacheDirectory: URL?

    init() {
        // Setting up the cache directory URL
        if let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            self.cacheDirectory = cacheDir
            print("Cache Directory: \(cacheDir)")
        }
    }

    func cache(_ data: Data, forID id: UUID) -> URL? {
        guard let cacheDirectory = self.cacheDirectory else { return nil }
        
        let fileURL = cacheDirectory.appendingPathComponent(id.uuidString)
        
        do {
            try data.write(to: fileURL)
            print("File cached at: \(fileURL)")
            return fileURL
        } catch {
            print("Error caching file: \(error.localizedDescription)")
            return nil
        }
    }

    func clearCache() {
        guard let cacheDirectory = self.cacheDirectory else { return }
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for fileURL in fileURLs {
                try FileManager.default.removeItem(at: fileURL)
            }
            
            print("Cache cleared.")
        } catch {
            print("Error clearing cache: \(error.localizedDescription)")
        }
    }
}
