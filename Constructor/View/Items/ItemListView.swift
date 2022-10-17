//
//  ItemListView.swift
//  Constructor
//
//  Created by Denys on 05.06.2022.
//

import SwiftUI

struct ItemListView: View {
    //@EnvironmentObject var coreDataVM: CoreDataRelationshipViewModel
    //    @EnvironmentObject var itemsVM: ItemsDataManager
    //    @EnvironmentObject var projectVM: ProjectsDataManager
    @EnvironmentObject var superVM: SuperViewModel
    @State var isAddingItem = false
    @State var isAlert = false
    @State var isActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchView(searchText: $superVM.searchItems)
                itemList
                    .alert("Please, add a Project", isPresented: $isAlert, actions: {
                        Button(role: .cancel) {
                            //
                        } label: {
                            Text("OK")
                        }
                        
                    })
            }
            
            .navigationTitle("All Items")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if !superVM.projects.isEmpty {
                            self.isAddingItem = true
                        } else {
                            self.isAlert = true
                        }
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isAddingItem) {
                        AddItemView()
                    }
                    
                }
            }
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}

extension ItemListView {
    var itemList: some View {
        List {
            ForEach(superVM.items) { item in
                NavigationLink {
                    ItemDetailsView(item: item)
                } label: {
                    HStack{
                        Text("\(item.name ?? "")")
                        Spacer()
                        Text("\(item.price.asString2Decimal())")
                    }
                    
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button {
                        withAnimation(.easeOut(duration: 0.1)) {
                            superVM.deleteItem(item: item)
                        }
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                }
            }
        }
        
    }
}
