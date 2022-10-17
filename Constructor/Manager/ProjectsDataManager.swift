//
//  ProjectsViewModel.swift
//  Constructor
//
//  Created by Denys on 16.07.2022.
//

import Foundation
import CoreData

class ProjectsDataManager: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    @Published var projects: [ProjectEntity] = [] //empty array with projects
    
    init() {
        getProjects()
    }
    
    //selected project property
    var selectedProject : ProjectEntity? {
        get {
            projects.first { project in
                project.isSelected == true
            }
        }
    }
    
    //add projects from core to array
    private func getProjects() {
        let request = NSFetchRequest<ProjectEntity>(entityName: "ProjectEntity")
        
        do {
            projects = try manager.context.fetch(request)
        } catch let error {
            print("Error project fetching \(error.localizedDescription)")
        }
    }
    
    //add project to core
    func addProject(name: String, budget: String) {
        self.unselectAllProject()
        let newProject = ProjectEntity(context: manager.context)
        newProject.projectID = UUID().uuidString
        newProject.name = name
        newProject.isSelected = true
        newProject.budget = Double(budget) ?? 0
        save()
    }
    
    //unselect all project
    func unselectAllProject() {
        for project in projects {
            project.isSelected = false
        }
    }
    
    //update project
    func updateProject(project: ProjectEntity, name: String) {
        project.name = name
        save()
    }
    
    //delete project and all conected items and products
    func deleteProject(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let project = projects[index]
            
            //delete all connected products
            if let products = project.products?.allObjects as? [ProductEntity] {
                for product in products {
                    deleteProduct(product: product)
                }
            }
            
            //delete all connected items
            if let items = project.items?.allObjects as? [ItemEntity] {
                for item in items {
                    deleteItem(item: item)
                }
            }
            
            manager.context.delete(project)
            
        }
        save()
    }
    
    //delete specific item
    private func deleteItem(item: ItemEntity) {
        manager.context.delete(item)
    }
    
    //delete specific product and all conected item counts
    private func deleteProduct(product: ProductEntity) {
        deleteItemCounts(product: product)
        manager.context.delete(product)
    }
    
    //delete item counts from project
    private func deleteItemCounts(product: ProductEntity) {
        if let itemCounts = product.itemCounts?.allObjects as? [ItemCountEntity] {
            for itemCount in itemCounts {
                manager.context.delete(itemCount)
            }
        }
    }
    
    func ZAKUPKA(items: [ItemModel], project: ProjectEntity?) {
        guard let project = project else {return}
        
        guard let projectItems = project.items?.allObjects as? [ItemEntity] else {return}
        
        for model in items {
            guard let item = projectItems.first(where: {$0.itemID == model.id}) else {return}
            project.budget -= item.price * (Double(model.count) ?? 0)
        }
        
        save()
    }
    
    func save() {
        projects.removeAll()
        self.manager.save()
        self.getProjects()
    }
}
