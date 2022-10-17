//
//  ProductListView.swift
//  Constructor
//
//  Created by Denys on 05.06.2022.
//

import SwiftUI

struct ProductListView: View {
    @EnvironmentObject var superVM: SuperViewModel
    @State var isAddingProduct = false
    @State var isAlert = false
    @State var showDetailView = false
    @State var selectedProduct: ProductEntity? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SearchView(searchText: $superVM.searchProducts)
                    productList
                        .alert("Please, add a Project", isPresented: $isAlert, actions: {
                            Button(role: .cancel) {
                                //
                            } label: {
                                Text("OK")
                            }
                            
                        })
                }
                .navigationTitle("All Products")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if !superVM.projects.isEmpty {
                                self.isAddingProduct = true
                            } else {
                                self.isAlert = true
                            }
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $isAddingProduct) {
                            AddProductView()
                        }
                        
                    }
                }
            }
            .background(
                NavigationLink(isActive: $showDetailView, destination: {
                    if let selectedProduct = selectedProduct {
                        ProductDetailsView(product: selectedProduct)
                    }
                }, label: {
                    EmptyView()
                })
            )
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}

extension ProductListView {
    
    var productList: some View {
        List {
            ForEach(superVM.products) { product in
                HStack{
                    Text("\(product.name ?? "Unnamed Product")")
                }
                
                .onTapGesture {
                    selectProduct(product: product)
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        superVM.deleteProduct(product: product)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
    }
    
    func selectProduct(product: ProductEntity) {
        selectedProduct = product
        showDetailView.toggle()
    }
}
