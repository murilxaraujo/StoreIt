//
//  AddStorageLocationView.swift
//  StoreIt
//
//  Created by Murilo Araujo on 21/02/24.
//  Copyright © 2024 M O DE ARAUJO TECNOLOGIA DA INFORMACAO LTDA. All rights reserved.
//

import SwiftUI

struct AddStorageLocationView<Presenter>: View where Presenter: AddStorageLocationPresenterType {
    @StateObject var presenter: Presenter
    
    var body: some View {
        Form {
            Section {
                VStack {
                    HStack {
                        Image(systemName: "map.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .foregroundStyle(Color.accentColor)
                    }.padding()
                    Text("What is the new location name?")
                        .font(.title3)
                    TextField("Location name", text: $presenter.locationName)
                        .textFieldStyle(.plain)
                        .padding()
                }
            }
            
            Section("Parent location") {
                VStack(alignment: .center) {
                    Text("No locations added yet")
                        .font(.caption)
                        .opacity(0.8)
                }
            }
        }
        .navigationTitle("Add location")
        .toolbar(content: {
            Button("Save") {
                presenter.addStorageLocation()
            }
        })
    }
}

#Preview {
    NavigationStack {
        AddStorageLocationView(presenter: AddStorageLocationPresenterMock())
    }
}

fileprivate class AddStorageLocationPresenterMock: AddStorageLocationPresenterType {
    @Published var locationName: String = ""
    
    func addStorageLocation() {
        // empty
    }
    
    
}
