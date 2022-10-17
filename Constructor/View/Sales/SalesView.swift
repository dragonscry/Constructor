//
//  SalesView.swift
//  Constructor
//
//  Created by Denys on 12.10.2022.
//

import SwiftUI

struct SalesView: View {
    var body: some View {
        NavigationView {
            List{
                
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
