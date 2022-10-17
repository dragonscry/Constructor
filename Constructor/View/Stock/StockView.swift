//
//  StockView.swift
//  Constructor
//
//  Created by Denys on 27.09.2022.
//

import SwiftUI

struct StockView: View {
    
    @EnvironmentObject var superVM: SuperViewModel
    
    @State var itemsToBasket = Set<ItemEntity>()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(superVM.items) { item in
                    HStack {
                        Text(item.name ?? "")
                        Spacer()
                        if itemsToBasket.contains(item) {
                            Image(systemName: "cart.fill")
                        } else {Image(systemName: "cart")}
                        Text(item.storageCount.asString2Decimal())
                    }
                    .onTapGesture {
                        if !itemsToBasket.contains(item){
                            itemsToBasket.insert(item)
                        } else {
                            itemsToBasket.remove(item)
                        }
                    }
                }

            }
            .navigationTitle("Stock")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        BasketWithItems(itemsToBasket: $itemsToBasket)
                    } label: {
                        basket
                    }

                }
            }
        }
    }
}
//
//struct StockView_Previews: PreviewProvider {
//    static var previews: some View {
//        StockView()
//    }
//}

extension StockView {
    
    var basket: some View {
        ZStack {
            Image(systemName: "cart")
                .resizable()
                .scaledToFit()
            if itemsToBasket.count > 0 {
                Text("\(itemsToBasket.count)")
                    .fontWeight(.bold)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(.horizontal, 4)
                    .background {
                        Capsule()
                            .fill(Color.red)
                    }
                    .offset(x: 15, y: -15)
            }
            
            
        }
        .frame(width: 30, height: 30)
    }
}
