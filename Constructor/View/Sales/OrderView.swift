//
//  OrderView.swift
//  Constructor
//
//  Created by Denys on 12.10.2022.
//

import SwiftUI

struct OrderView: View {
    
    @State private var isShowingProducts: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Order")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "cart.badge.plus")
                        .sheet(isPresented: $isShowingProducts) {
                            Text("Order")
                        }
                        .onTapGesture {
                            isShowingProducts.toggle()
                        }
                }
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
    var count = "0"
}
