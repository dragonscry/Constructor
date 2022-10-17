//
//  ProductDetailsView.swift
//  Constructor
//
//  Created by Denys on 17.06.2022.
//

import SwiftUI

struct ProductDetailsView: View {
    
    let product: ProductEntity
    @Environment(\.presentationMode) var presentationMode
    //    @EnvironmentObject var productVM: ProductsDataManager
    //    @EnvironmentObject var projectVM: ProjectsDataManager
    //    @EnvironmentObject var itemVM: ItemsDataManager
    @EnvironmentObject var superVM: SuperViewModel
    @State var name = ""
    @State var procent = ""
    @State var price = ""
    @State var isShowingSelectItem = false
    @State var isShowingItem = false
    
    var body: some View {
        
        if product.isEditable {
            isEditableProduct
        } else {
            isNotEditableProduct
        }
        
    }
    
}

extension ProductDetailsView {
    var isEditableProduct: some View {
        VStack {
            HStack {
                DefaultPhotoView()
                
                VStack {
                    TextField(product.name ?? "", text: $name)
                        .underlineTextField()
                }
                
            }
            .onAppear(perform: defaultValues)
            .padding(.horizontal)
            
            List {
                
                Section {
                    Text("Own Price: \(String(format: "%.2f", product.price))")
                    
                }
                
                Section {
                    HStack {
                        Text("Procent for product:")
                        Spacer()
                        TextField("Procent", text: $procent,onCommit: {
                            superVM.updateProcent(product: product, procent: procent)
                        })
                        .underlineTextField()
                    }
                    Text("Total price: \(String(format: "%.2f", product.totalPrice))")
                    
                }
                
                if let items = product.items?.allObjects as? [ItemEntity] {
                    
                    Section(header: Text("Items in product")) {
                        ForEach(superVM.items.filter({ item in
                            items.contains(item)
                        })){ item in
                            VStack {
                                ItemRowWithStepper(item: item, product: product, itemCount: getItemCount(item: item))
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    self.deleteItemFromProduct(item: item)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            
                        }
                    }
                }
            }
            
            
            
            HStack {
                Button {
                    superVM.updateProduct(product: product, name: name)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    DefaultButton(text: "Save")
                }
                
                Spacer()
                
                Button {
                    isShowingSelectItem = true
                } label: {
                    DefaultButton(text: "Select Item")
                }
                .sheet(isPresented: $isShowingSelectItem) {
                    AddItemsView(product: product)
                }
                
                
            }
            .padding(.horizontal)
        }
    }
    
    var isNotEditableProduct: some View {
        VStack {
            HStack {
                DefaultPhotoView()
                
                VStack {
                    TextField(product.name ?? "", text: $name)
                        .underlineTextField()
                    
                    TextField(String(format: "%.2f", product.price), text: $price)
                        .underlineTextField()
                }
                
            }
            .onAppear(perform: defaultValues)
            .padding(.horizontal)
            
            Spacer()
            
            HStack {
                Button {
                    superVM.updateProduct(product: product, name: name, price: price)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    DefaultButton(text: "Save")
                }
                
                Spacer()
                
            }
            .padding(.horizontal)
        }
    }
    
    //check product name and add it if exist
    private func defaultValues() {
        if self.name == "" {
            self.name = product.name ?? ""
        }
        if self.price == "" {
            self.price = String(format: "%.2f", product.price)
        }
        self.procent = String(product.procent)
        superVM.recalculationProduct(product: product)
    }
    
    //get item count connected to item
    private func getItemCount(item: ItemEntity) -> ItemCountEntity? {
        
        if let itemCounts = product.itemCounts?.allObjects as? [ItemCountEntity] {
            let count = itemCounts.first { itemCount in
                itemCount.idItem == item.itemID
            }
            
            return count
        }
        
        return nil
    }
    
    //delete item from product
    private func deleteItemFromProduct(item: ItemEntity) {
        self.product.removeFromItems(item)
        if let itemCount = getItemCount(item: item) {
            self.product.removeFromItemCounts(itemCount)
        }
        superVM.recalculationProduct(product: product)
    }
}

struct AddItemsView: View {
    
    //    @EnvironmentObject var productVM: ProductsDataManager
    //    @EnvironmentObject var itemsVM: ItemsDataManager
    //    @EnvironmentObject var projectVM: ProjectsDataManager
    @EnvironmentObject var superVM: SuperViewModel
    @Environment(\.presentationMode) var presentationMode
    
    let product: ProductEntity
    @State var selectedRows = Set<ItemEntity>()
    
    var body: some View {
        VStack {
            List {
                ForEach(superVM.items){ item in
                    HStack{
                        ItemRow(item: item)
                        if selectedRows.contains(item) {
                            Image(systemName: "heart.fill")
                        }
                    }.onTapGesture {
                        if !selectedRows.contains(item){
                            selectedRows.insert(item)
                        } else {
                            selectedRows.remove(item)
                        }
                    }
                }
            }
        }
        Button {
            superVM.addItemsToProduct(items: selectedRows, product: product)
            superVM.recalculationProduct(product: product)
            presentationMode.wrappedValue.dismiss()
        } label: {
            DefaultButton(text: "Save")
        }
        
    }
}


//struct ProductDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductDetailsView()
//    }
//}
