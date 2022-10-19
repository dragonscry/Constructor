//
//  SaleBuyManager.swift
//  Constructor
//
//  Created by Denys on 19.10.2022.
//

import Foundation
import CoreData
import SwiftUI

class SaleBuyManager: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var buyStocks: [BuyStockEntity] = []
    @Published var saleOrders: [SaleOrderEntity] = []
    
    init() {
        getBuyStock()
        getSaleOrder()
    }
    
    private func getBuyStock() {
        let request = NSFetchRequest<BuyStockEntity>(entityName: "BuyStockEntity")
        do {
            buyStocks = try manager.context.fetch(request)
        }catch let error {
            print("Error Buy Stocks fetching \(error.localizedDescription)")
        }
    }
    
    private func getSaleOrder() {
        let request = NSFetchRequest<SaleOrderEntity>(entityName: "SaleOrderEntity")
        do {
            saleOrders = try manager.context.fetch(request)
        }catch let error {
            print("Error Sale Orders fetching \(error.localizedDescription)")
        }
    }
    
    //func for creating buystock entity
    func addBuyStock(itemModels: [ItemModel], project: ProjectEntity?) {
        guard let project = project else {
            print("Project is not selected")
            return
        }
        let newBuyStock = BuyStockEntity(context: manager.context)
        newBuyStock.buyStockId = UUID().uuidString
        newBuyStock.date = Date.now
        newBuyStock.price = 0
        for itemModel in itemModels {
            newBuyStock.price += (Double(itemModel.count) ?? 0) * itemModel.price
        }
        
        project.addToBuyStock(newBuyStock)
        
        // TODO ADD ITEM COUNT
    }
    
   // func for creating sale order entity
    func addSaleOrder(productModels: [ProductModel], project: ProjectEntity?){
        guard let project = project else {
            print("Project is not selected")
            return
        }
        let newSaleOrder = SaleOrderEntity(context: manager.context)
        newSaleOrder.date = Date.now
        newSaleOrder.saleStockId = UUID().uuidString
        newSaleOrder.price = 0
        //TODO ADD COUNT PRODUCT
    }
    
    
    func save() {
        buyStocks.removeAll()
        saleOrders.removeAll()
        manager.save()
        getBuyStock()
        getSaleOrder()
        
    }
}
