//
//  StorageItemsView.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
//

import SwiftUI

struct StorageItemsView<Presenter>: View where Presenter: StorageItemsPresenterType {
    @StateObject var presenter: Presenter
    
    var body: some View {
        content
            .navigationTitle("Items")
            .toolbar(content: {
                NavigationLink(value: StorageItemsCoordinator.Destinations.addItem) {
                    Image(systemName: "plus")
                }
            })
            .onAppear {
                presenter.getItems()
            }
    }
    
    var content: some View {
        List($presenter.items, id: \.tag) { item in
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(Gradient(colors: [.blue, .blue.opacity(0.8)]))
                    if let imageData = item.imageData.wrappedValue,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.white)
                    } else {
                        Image(systemName: "key")
                    }
                    
                }
                VStack(alignment: .leading) {
                    Text(item.name.wrappedValue)
                        .font(.subheadline)
                        .bold()
                    if let description = item.itemDescription.wrappedValue {
                        Text(description)
                            .font(.footnote)
                    }
                }.padding()
                Spacer()
                HStack {
                    Image(systemName: "tag")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                    Text("\(String(format: "%05d", item.tag.wrappedValue))")
                        .font(.caption)
                        .multilineTextAlignment(.trailing)
                }
                .padding(8)
                .foregroundStyle(.white)
                .background {
                    Color.blue
                }
                .cornerRadius(8)
                    
            }
        }
    }
}

#Preview {
    NavigationStack {
        StorageItemsView(presenter: StorageItemsPresenterMock())
    }
}

fileprivate class StorageItemsPresenterMock: StorageItemsPresenterType {
    func getItems() {
        // empty
    }
    
    @Published var items: [StorageItem] = [
        StorageItem(tag: 1, name: "TV", itemDescription: "TV Sala", pucharseDate: nil),
        StorageItem(tag: 2, name: "TV", itemDescription: "TV Sala", pucharseDate: Date())
    ]
}
