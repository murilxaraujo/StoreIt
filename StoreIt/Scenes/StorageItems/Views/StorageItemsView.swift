//
//  StorageItemsView.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
//

import SwiftUI

struct StorageItemsView: View {
    var body: some View {
        content
            .navigationTitle("Items")
            .toolbar(content: {
                NavigationLink(value: StorageItemsCoordinator.Destinations.addItem) {
                    Image(systemName: "plus")
                }
            })
    }
    
    var content: some View {
        List {
            createCell()
        }
    }
    
    @ViewBuilder
    func createCell() -> some View {
        HStack {
            Image(systemName: "flag")
                .resizable()
                .backgroundStyle(.purple)
                .aspectRatio(contentMode: .fill)
                .frame(width: 16, height: 17)
                
        }
    }
}

#Preview {
    NavigationStack {
        StorageItemsView()
    }
}
