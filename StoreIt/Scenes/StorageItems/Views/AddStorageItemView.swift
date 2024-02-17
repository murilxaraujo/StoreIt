//
//  AddStorageItemView.swift
//  StoreIt
//
//  Created by Murilo Araujo on 12/02/24.
//

import SwiftUI
import PhotosUI

struct AddStorageItemView<Presenter>: View where Presenter: AddStorageItemPresenterType {
    @StateObject var presenter: Presenter
    @State var selectedItems: [PhotosPickerItem] = []
    @State var pucharseDate: Date = Date()
    
    var body: some View {
        content
            .navigationTitle("Add item")
            .toolbar {
                switch presenter.state {
                case .idle:
                    Button(action: tappedSaveItem,
                           label: {
                        Text("Save")
                    })
                case .loading:
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
    }
    
    private var content: some View {
        Form {
            imageSection
            basicInfoSection
        }
    }
    
    private var imageSection: some View {
        Section() {
            PhotosPicker(selection: $selectedItems,
                         maxSelectionCount: 1,
                         matching: .images,
                         photoLibrary: .shared()) {
                if let image = presenter.itemImage {
                    Image(uiImage: UIImage(data: image)!)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 400)
                        .clipShape(RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/))
                } else {
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
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
            }.onChange(of: selectedItems, updateSelectedImage)
        }.listRowBackground(Color(UIColor.systemGroupedBackground))
    }
    
    private var basicInfoSection: some View {
        Section("Basic information") {
            HStack {
                Text("Item #")
                Spacer()
                Text(String(format: "%05d", presenter.itemNumber))
            }
            TextField("Name", text: $presenter.itemName)
            TextField("Descrição", text: $presenter.itemDescription)
            
            if presenter.pucharseDate == nil {
                Button("Add pucharse date", action: addPucharseDate)
            } else {
                DatePicker("Pucharse date",
                           selection: $pucharseDate,
                           displayedComponents: [.date])
                    .onChange(of: pucharseDate, updatePucharseDate)
            }
        }
    }
    
    private func tappedSaveItem() {
        presenter.tappedSaveItem()
    }
    
    private func addPucharseDate() {
        presenter.pucharseDate = Date()
    }
    
    private func updatePucharseDate() {
        presenter.pucharseDate = pucharseDate
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
        AddStorageItemView(presenter: AddStorageItemPresenterMock())
    }
}

fileprivate class AddStorageItemPresenterMock: AddStorageItemPresenterType {
    var delegate: AddStoragePresenterDelegate?
    @Published var pucharseDate: Date?
    @Published var itemName: String = String()
    @Published var itemImage: Data?
    @Published var itemDescription: String = String()
    @Published var state: AddStorageItemState = .idle
    @Published var itemNumber: Int = 3
    
    func tappedSaveItem() {
        state = .loading
    }
}
