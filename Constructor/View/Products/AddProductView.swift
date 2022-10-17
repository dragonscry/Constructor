//
//  AddProductView.swift
//  Constructor
//
//  Created by Denys on 06.06.2022.
//

import SwiftUI

struct AddProductView: View {
    
    @Environment(\.presentationMode) var presentationMode
    //@EnvironmentObject var coreDataVM: CoreDataRelationshipViewModel
//    @EnvironmentObject var productVM: ProductsDataManager
//    @EnvironmentObject var projectVM: ProjectsDataManager
    @EnvironmentObject var superVM: SuperViewModel
    @State var name = ""
    @State var items = Set<ItemEntity>()
    @State var price = ""
    
    var arrayItems: [ItemEntity] {
        Array(items)
    }
    
    @State var isShowingSelectItem = false
    
    
    var body: some View {
        VStack {
            productInfo
            itemList
            buttons
            Spacer()
            
        }
        .padding()
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}

extension AddProductView {
    
    var buttons: some View {
        HStack {
            Button {
                self.isShowingSelectItem = true
            } label: {
                DefaultButton(text: "Select item")
            }
            .sheet(isPresented: $isShowingSelectItem) {
                SelectItemView(selectedRows: $items)
            }
            
            Spacer()
            
            Button {
                
                if !price.isEmpty {
                    superVM.addProduct(name: name, price: price, project: superVM.selectedProject)
                }
                else if items.isEmpty {
                    superVM.addProduct(name: name, project: superVM.selectedProject)
                } else if !items.isEmpty {
                    superVM.addProduct(name: name, items: items, project: superVM.selectedProject)
                }
                presentationMode.wrappedValue.dismiss()
            } label: {
                DefaultButton(text: "Save")
            }
        }
        .padding(.bottom, 40)
    }
    
    var productInfo: some View {
        HStack {
            DefaultPhotoView()
            VStack {
                TextField("Type Product Name", text: $name)
                    .underlineTextField()
                VStack {
                    TextField("Type Product Price", text: $price)
                        .numericTextField()
                        .underlineTextField()
                    Text("Note: if you type product price product became uneditable")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            
        }
    }
    
    var itemList: some View {
        List {
            Section(header: Text("Added items")) {
                ForEach(arrayItems, id: \.self) { item in
                    ItemRow(item: item)
                }
            }
        }
    }
}
