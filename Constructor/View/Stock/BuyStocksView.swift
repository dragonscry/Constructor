//
//  BuyStocksView.swift
//  Constructor
//
//  Created by Denys on 20.10.2022.
//

import SwiftUI

struct BuyStocksView: View {
    
    @EnvironmentObject var superVM: SuperViewModel
    
    var body: some View {
        List {
            ForEach(superVM.buys) { buy in
                HStack {
                    Text(buy.buyStockId ?? "")
                    Spacer()
                    Text("\(buy.price)")
                }
                
            }
        }
    }
}

struct BuyStocksView_Previews: PreviewProvider {
    static var previews: some View {
        BuyStocksView()
    }
}
