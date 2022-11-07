//
//  OrderView.swift
//  Constructor
//
//  Created by Denys on 12.10.2022.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var superVM: SuperViewModel
    
    @State var productsInOrder = [ProductModel]()
    @Environment(\.dismiss) var dismiss
    
    @State private var isShowingProducts: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach(productsInOrder) { order in
                    HStack {
                        Text(order.name)
                        Spacer()
                        Text(order.count)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Order")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "cart.badge.plus")
                        .sheet(isPresented: $isShowingProducts) {
                            ProductsForOrderView(products: $productsInOrder)
                        }
                        .onTapGesture {
                            isShowingProducts.toggle()
                        }
                }
            }
            Button {
                superVM.PRODAZHA(products: productsInOrder)
                superVM.addSaleOrder(productModels: productsInOrder, project: superVM.selectedProject)
                dismiss()
            } label: {
                Text("Save")
            }

        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}

struct ProductModel : Codable, Hashable, Identifiable {
    let id: String
    let name: String
    let price: Double
    var count = "0"
}
