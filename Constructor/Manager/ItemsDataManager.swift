//
//  ItemsViewModel.swift
//  Constructor
//
//  Created by Denys on 16.07.2022.
//

import Foundation
import CoreData

class ItemsDataManager: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    @Published var items: [ItemEntity] = [] //empty array with items
    
    init() {
        getItems()
    }
    
    //add items from core to array
    private func getItems() {
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        
        do {
            items = try manager.context.fetch(request)
        } catch let error {
            print("Error product fetching \(error.localizedDescription)")
        }
        
    }
    
    //add item to core NEED UPD
    func addItem(name: String, price: Double, description: String, dimension: String, project: ProjectEntity?) {
        
        guard let project = project else {
            print("Project is not selected")
            return
        }
        
        let newItem = ItemEntity(context: manager.context)
        newItem.itemID = UUID().uuidString
        newItem.name = name
        newItem.price = price
        newItem.dimension = dimension
        newItem.desc = description
        newItem.storageCount = 0.0
        
        project.addToItems(newItem)
        
        save()
    }
    
    //update item entity
    func updateItem(item: ItemEntity, name: String, price: Double) {
        item.name = name
        item.price = price
        save()
    }
    
    //delete item from core
    func deleteItem(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let item = items[index]
            manager.context.delete(item)
        }
        save()
    }
    
    // delete directly item from core
    func deleteItem2(item: ItemEntity) {
        manager.context.delete(item)
        save()
    }
    
    
    func save() {
        items.removeAll()
        self.manager.save()
        self.getItems()
    }
    
    func updateItemCount(itemModels: [ItemModel]) {
        for model in itemModels {
            let item = items.first {$0.itemID == model.id}
            item?.storageCount += Double(model.count) ?? 0
        }
        save()
    }
}
