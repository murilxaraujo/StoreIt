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
        List {
            ForEach($presenter.items, id: \.tag) { item in
                StorageItemCell(imageData: item.imageData.wrappedValue,
                              title: item.name.wrappedValue,
                              subtitle: item.itemDescription.wrappedValue,
                              id: item.tag.wrappedValue)
            }.onDelete(perform: delete)
        }
    }
    
    func delete(at offsets: IndexSet) {
        presenter.deleteItems(at: offsets)
    }
}

#Preview {
    NavigationStack {
        StorageItemsView(presenter: StorageItemsPresenterMock())
    }
}

fileprivate class StorageItemsPresenterMock: StorageItemsPresenterType {
    func deleteItems(at offSets: IndexSet) {
        // empty
    }
    
    func getItems() {
        // empty
    }
    
    @Published var items: [StorageItem] = [
        StorageItem(tag: 1, name: "TV", itemDescription: "TV Sala", pucharseDate: nil),
        StorageItem(tag: 2, name: "TV", itemDescription: "TV Sala", pucharseDate: Date())
    ]
}

struct StorageItemCell: View {
    let imageData: Data?
    let title: String
    let subtitle: String?
    let id: Int
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(Gradient(colors: [.accentColor, .accentColor.opacity(0.8)]))
                if let imageData = imageData,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "shippingbox.fill")
                        .resizable()
                        .foregroundStyle(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
                
            }
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .bold()
                if let description = subtitle {
                    Text(description)
                        .font(.footnote)
                }
            }.padding()
            Spacer()
            HStack {
                Image(systemName: "tag")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                Text("\(String(format: "%05d", id))")
                    .font(.caption)
                    .multilineTextAlignment(.trailing)
            }
            .padding(8)
            .foregroundStyle(.white)
            .background {
                Color.accentColor
            }
            .cornerRadius(8)
            
        }
    }
}
