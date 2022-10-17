//
//  ContentView.swift
//  Constructor
//
//  Created by Denys on 23.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            ProjectListView()
                .tabItem {
                    VStack {
                        Image(systemName: "display")
                        Text("Projects")
                    }
                }
            TemplatesView()
                .tabItem {
                    VStack{
                        Image(systemName: "list.bullet.rectangle.portrait")
                        Text("Templates")
                    }
                }
            
            StockView()
                .tabItem {
                    VStack {
                        Image(systemName: "suitcase")
                        Text("Stock")
                    }
                    
                }
            SalesView()
                .tabItem {
                    VStack {
                        Image(systemName: "suitcase.cart")
                        Text("Orders")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
