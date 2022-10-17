//
//  StockView.swift
//  Constructor
//
//  Created by Denys on 04.08.2022.
//

import SwiftUI

struct TemplatesView: View {
    
    @State private var selectedView: SelectView = .item
    
    var body: some View {
        VStack{
            Picker("Select View", selection: $selectedView) {
                ForEach(SelectView.allCases) { view in
                        Text(view.rawValue.capitalized)
                    }
            }
            .padding(.horizontal)
            .pickerStyle(.segmented)
            
            Spacer()
            
            switch selectedView {
            case .item:
                ItemListView()
            case .product:
                ProductListView()
            }
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        TemplatesView()
    }
}

enum SelectView: String, CaseIterable, Identifiable {
    case item, product
    var id: Self { self }
}
