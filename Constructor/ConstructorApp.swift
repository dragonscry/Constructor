//
//  ConstructorApp.swift
//  Constructor
//
//  Created by Denys on 23.05.2022.
//

import SwiftUI

@main
struct ConstructorApp: App {
    
//    @StateObject var projectsVM: ProjectsDataManager = ProjectsDataManager()
    @StateObject var superVM: SuperViewModel = SuperViewModel()
//    @StateObject var itemsVM: ItemsDataManager = ItemsDataManager()
//    @StateObject var productsVM: ProductsDataManager = ProductsDataManager()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                ContentView()
            }
            //.environmentObject(projectsVM)
            //.environmentObject(itemsVM)
            //.environmentObject(productsVM)
            .environmentObject(superVM)
        }
    }
}
