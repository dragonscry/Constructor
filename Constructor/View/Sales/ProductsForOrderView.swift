//
//  ProductsForOrderView.swift
//  Constructor
//
//  Created by Denys on 02.11.2022.
//

import SwiftUI

struct ProductsForOrderView: View {
    
    @EnvironmentObject var superVM: SuperViewModel
    @Binding var products: [ProductModel]
    @State var productsTemp = [ProductModel]()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            List {
                ForEach($productsTemp) { $temp in
                    HStack {
                        Text("\(temp.name)")
                        Spacer()
                        TextField(temp.count, text: $temp.count)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .onAppear {
                productsToProductsModel()
            }
            
            Button {
                addProductsToOrder()
                dismiss()
            } label: {
                Text("Save")
            }

        }
    }
}

extension ProductsForOrderView {
    func productsToProductsModel() {
        for product in superVM.products {
            productsTemp.append(ProductModel(id: product.productID ?? "", name: product.name ?? "", price: product.price))
        }
    }
    
    func addProductsToOrder() {
        for product in productsTemp {
            if product.count != "0" {
                products.append(product)
            }
        }
    }
}

//struct ProductsForOrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductsForOrderView()
//    }
//}
