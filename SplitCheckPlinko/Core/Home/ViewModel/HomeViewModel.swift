//
//  HomeViewModel.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    static let shared = HomeViewModel()
    
    @Published var usersList: [User] = []
    
    init() {
        getCoreData()
    }
    
    public func getCoreData() {
        usersList = CoreDataManager.shared.fetchUsers()
    }
    
    func addNewUser(name: String) {
        
    }
    
    func deleteUser(user: User) {
        CoreDataManager.shared.deleteUser(user: user)
        getCoreData()
    }
    
    func deleteProduct(user: User, idProduct: String) {
        if !idProduct.isEmpty {
            CoreDataManager.shared.deleteProduct(for: user, productID: idProduct)
            
            user.orderedProducts.removeAll { $0.id == idProduct }
            user.totalPrice = user.orderedProducts.reduce(0.0) { $0 + $1.price * Double($1.count) }
            
            CoreDataManager.shared.saveContext()
        }
        getCoreData()
    }
    
    func currentDateFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd"
        return formatter.string(from: Date())
    }
}
