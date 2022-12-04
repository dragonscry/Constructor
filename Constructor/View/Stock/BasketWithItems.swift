//
//  BasketWithItems.swift
//  Constructor
//
//  Created by Denys on 05.10.2022.
//

import SwiftUI

struct BasketWithItems: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var superVM: SuperViewModel
    
    @Binding var itemsToBasket : Set<ItemEntity>
    
    @State private var itemModels = [ItemModel]()
    
    var body: some View {
        VStack {
            List {
                ForEach($itemModels) { $model in
                    HStack {
                        Text("\(model.name)")
                        Spacer()
                        TextField(model.count, text: $model.count)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            
            Button {
                superVM.addItemsCount(itemModels: itemModels)
                superVM.ZAKUPKA(items: itemModels)
                superVM.addBuyStock(itemModels: itemModels, project: superVM.selectedProject)
                itemsToBasket.removeAll()
                dismiss()
            } label: {
                Text("Save")
            }
        }
        .onAppear{
            itemToItemModel()
        }
    }
}

extension BasketWithItems {
    
    func itemToItemModel() {
        
        for item in itemsToBasket {
            itemModels.append(ItemModel(id: item.itemID ?? "", name: item.name ?? "", price: item.price))
        }
    }
}

//struct BasketWithItems_Previews: PreviewProvider {
//    static var previews: some View {
//        BasketWithItems()
//    }
//}

struct ItemModel: Codable, Hashable, Identifiable {
    let id: String
    let name: String
    let price: Double
    var count = "0"
}

struct ItemModelCount: Codable, Hashable, Identifiable {
    let id: String
    var count: Double
}
