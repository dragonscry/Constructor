//
//  ItemDetailsView.swift
//  Constructor
//
//  Created by Denys on 06.06.2022.
//

import SwiftUI

struct ItemDetailsView: View {
    
    //@EnvironmentObject var coreDataVM: CoreDataRelationshipViewModel
//    @EnvironmentObject var itemVM: ItemsDataManager
//    @EnvironmentObject var productVM: ProductsDataManager
    @EnvironmentObject var superVM: SuperViewModel
    @Environment(\.presentationMode) var presentationMode
    var item : ItemEntity
    @State var name = ""
    @State var price = ""
    
    var body: some View {
        VStack {
            
            itemDetails

            buttons

            
            Spacer()
            
        }
        .onAppear(perform: defaultValues)
    }

}

//struct ItemDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemDetailsView(item: Item(name: "Logan", price: 20))
//    }
//}

extension ItemDetailsView {
    var itemDetails : some View {
        HStack {
            
            DefaultPhotoView()
            
            VStack {
                TextField(item.name ?? "", text: $name)
                    .underlineTextField()
                
                TextField("\(item.price)", text: $price)
                    .numericTextField()
                    .underlineTextField()
                    
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 50)
    }
    
    var buttons: some View {
        Button {
            superVM.updateItem(item: item, name: name, price: Double(price) ?? 0)
            presentationMode.wrappedValue.dismiss()
        } label: {
            DefaultButton(text: "Save")
        }
    }
    
    
    private func defaultValues() {
        self.name = item.name ?? ""
        self.price = String(item.price)
    }
}
//Upd 0110
