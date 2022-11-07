//
//  SalesView.swift
//  Constructor
//
//  Created by Denys on 12.10.2022.
//

import SwiftUI

struct SalesView: View {
    
    @EnvironmentObject var superVM: SuperViewModel
    
    
    var body: some View {
        NavigationView {
            List{
                ForEach(superVM.orders){ order in
                    HStack {
                        Text(order.saleStockId ?? "")
                        Text("\(order.price)")
                    }
                }
            }
            .navigationTitle("Sales")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        OrderView()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }
    }
}

struct SalesView_Previews: PreviewProvider {
    static var previews: some View {
        SalesView()
    }
}
