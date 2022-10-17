//
//  ProjectViewModel.swift
//  Constructor
//
//  Created by Denys on 31.08.2022.
//

import Foundation
import Combine

class SuperViewModel: ObservableObject {
    
    private let projectsData: ProjectsDataManager = ProjectsDataManager()
    private let productsData: ProductsDataManager = ProductsDataManager()
    private let itemsData: ItemsDataManager = ItemsDataManager()
    
    private var cansellables = Set<AnyCancellable>()
    
    @Published var projects: [ProjectEntity] = []
    @Published var products: [ProductEntity] = []
    @Published var items: [ItemEntity] = []
    
    @Published var searchItems = ""
    @Published var searchProducts = ""
    
    var selectedProject: ProjectEntity = ProjectEntity()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        projectsData.$projects
            .sink { projects in
                self.projects = projects
                if let selectedProject = projects.first(where: { $0.isSelected}) {
                    self.selectedProject = selectedProject
                }
            }
            .store(in: &cansellables)
        
        productsData.$products
            .combineLatest(projectsData.$projects)
            .map(filterProducts)
            .sink { [weak self] products in
                self?.products = products
            }
            .store(in: &cansellables)
        
        itemsData.$items
            .combineLatest(projectsData.$projects)
            .map(filterItems)
            .sink { [weak self] items in
                self?.items = items
            }
            .store(in: &cansellables)
        
        $searchItems
            .combineLatest(itemsData.$items)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(searchItems)
            .sink { [weak self] serchedItem in
                self?.items = serchedItem
            }
            .store(in: &cansellables)
        
        $searchProducts
            .combineLatest(productsData.$products)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(searchProducts)
            .sink { [weak self] searchedProduct in
                self?.products = searchedProduct
            }
            .store(in: &cansellables)
        
    }
    
    private func searchItems(text: String, items: [ItemEntity]) -> [ItemEntity] {
        let filteredItems = filterItems(items: items, projects: projectsData.projects)
        guard !text.isEmpty else {
            return filteredItems
        }
        
        let lowercasedText = text.lowercased()
        
        return filteredItems.filter { item -> Bool in
            return item.name?.lowercased().contains(lowercasedText) ?? false
        }
    }
    
    private func searchProducts(text: String, products: [ProductEntity]) -> [ProductEntity] {
        let filteredProducts = filterProducts(products: products, projects: projectsData.projects)
        guard !text.isEmpty else {
            return filteredProducts
        }
        
        let lowercasedText = text.lowercased()
        
        return filteredProducts.filter { product -> Bool in
            return product.name?.lowercased().contains(lowercasedText) ?? false
        }
    }
    
    
    //MARK: Project Functions
    
    func addProject(name: String, budget: String) {
        projectsData.addProject(name: name, budget: budget)
    }
    
    func unselectAllProjects() {
        projectsData.unselectAllProject()
    }
    
    func updateProject(project: ProjectEntity, name: String) {
        projectsData.updateProject(project: project, name: name)
    }
    
    func deleteProject(at indexSet: IndexSet) {
        projectsData.deleteProject(at: indexSet)
    }
    
    func ZAKUPKA(items: [ItemModel]) {
        projectsData.ZAKUPKA(items: items, project: projectsData.selectedProject)
    }
    
    func saveProject(){
        projectsData.save()
    }
    
    //MARK: Item Functions
    
    func addItem(name: String, price: Double, description: String, dimension: String, project: ProjectEntity) {
        itemsData.addItem(name: name, price: price, description: description, dimension: dimension, project: project)
    }
    
    func updateItem(item: ItemEntity, name: String, price: Double){
        itemsData.updateItem(item: item, name: name, price: price)
    }
    
    func deleteItem(item: ItemEntity) {
        itemsData.deleteItem2(item: item)
    }
    
    func saveItem() {
        itemsData.save()
    }
    
    private func filterItems(items: [ItemEntity], projects: [ProjectEntity]) -> [ItemEntity] {
        guard let project = projects.first(where: { $0.isSelected }) else {return [ItemEntity]()}
        
        guard let projectItems = project.items?.allObjects as? [ItemEntity]
        else {return [ItemEntity]()}
        
        return items.filter { item in
            projectItems.contains(item)
        }
        
    }
    
    func updateCount(itemModels: [ItemModel]) {
        itemsData.updateItemCount(itemModels: itemModels)
    }
    
    //MARK: Product Functions
    
    func addProduct(name: String, project: ProjectEntity) {
        productsData.addProduct(name: name, project: project)
    }
    
    func addProduct(name: String, items: Set<ItemEntity>, project: ProjectEntity){
        productsData.addProduct(name: name, items: items, project: project)
    }
    
    func addProduct(name: String, price: String, project: ProjectEntity) {
        productsData.addProduct(name: name, price: price, project: project)
    }
    
    func addItemsToProduct(items: Set<ItemEntity>, product: ProductEntity) {
        productsData.addItemsToProduct(items: items, product: product)
    }
    
    func updateProduct(product: ProductEntity, name: String) {
        productsData.updateProduct(product: product, name: name)
    }
    
    func updateProduct(product: ProductEntity, name: String, price: String) {
        productsData.updateProduct(product: product, name: name, price: price)
    }
    
    func deleteProduct(product: ProductEntity) {
        productsData.deleteProduct(product: product)
    }
    
    func recalculationProduct(product: ProductEntity) {
        productsData.recalculationProduct(product: product)
    }
    
    func updateItemCount(itemCount: ItemCountEntity?, count: Double) {
        productsData.updateItemCount(itemCount: itemCount, count: count)
    }
    
    func updateProcent(product: ProductEntity, procent: String){
        productsData.updateProcent(product: product, procent: procent)
    }
    
    func saveProduct() {
        productsData.save()
    }
    
    private func filterProducts(products: [ProductEntity], projects: [ProjectEntity]) -> [ProductEntity] {
        guard let project = projects.first(where: { $0.isSelected }) else {return [ProductEntity]()}
        
        guard let projectProducts = project.products?.allObjects as? [ProductEntity]
        else {return [ProductEntity]()}
        
        return products.filter { product in
            projectProducts.contains(product)
        }
        
    }
    
}
