//
//  AddStorageItemView.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
//

import SwiftUI
import PhotosUI

struct AddStorageItemView: View {
    @StateObject var presenter: AddStorageItemPresenter
    @State var selectedItems: [PhotosPickerItem] = []
    
    var body: some View {
        content
            .navigationTitle("Add item")
            .toolbar {
                Button(action: tappedSaveItem,
                       label: {
                    Text("Save")
                })
            }
    }
    
    private var content: some View {
        Form {
            imageSection
            
            Section("Basic information") {
                TextField("Name", text: $presenter.itemName)
            }
        }
    }
    
    private var imageSection: some View {
        Section() {
            if let image = presenter.itemImage {
                Image(uiImage: UIImage(data: image)!)
                    .resizable()
                    .scaledToFit()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            } else {
                PhotosPicker(selection: $selectedItems,
                             maxSelectionCount: 1,
                             matching: .images,
                             photoLibrary: .shared()) {
                    VStack(alignment: .leading, content: {
                        Image(systemName: "plus.circle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(Color.accentColor)
                            .frame(width: 80, height: 80)
                            .padding()
                        Text("Add item image")
                            .padding(.bottom)
                            .foregroundStyle(Color.accentColor)
                    })
                }.onChange(of: selectedItems, updateSelectedImage)
                .frame(maxWidth: .infinity)
            }
        }.listRowBackground(Color(UIColor.systemGroupedBackground))
    }
    
    private func tappedSaveItem() {
        presenter.tappedSaveItem()
    }
    
    private func tappedAddImage() {
        
    }
    
    private func updateSelectedImage() {
        selectedItems.first?.loadTransferable(type: Data.self, completionHandler: { result in
            if case .success(let data) = result {
                presenter.itemImage = data
            }
        })
    }
}

#Preview {
    NavigationStack {
        AddStorageItemView(presenter: AddStorageItemPresenter())
    }
}
