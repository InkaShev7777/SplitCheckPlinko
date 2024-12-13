//
//  User.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import Foundation
import CoreData

class User: Identifiable {
    var id: String
    var userName: String
    var orderedProducts: [OrderedProduct]
    var totalPrice: Double
    
    init(id: String = UUID().uuidString, userName: String) {
        self.id = id
        self.userName = userName
        self.orderedProducts = []
        self.totalPrice = 0.0
    }
}

extension UserEntity {
    func toUser() -> User {
        let user = User(id: id ?? UUID().uuidString, userName: userName ?? "")
        if let productsData = self.orderedProducts,
           let products = try? JSONDecoder().decode([OrderedProduct].self, from: productsData) {
            user.orderedProducts = products
        }
        user.totalPrice = totalPrice ?? 0.0
        return user
    }
}


extension User {
    func toUserEntity(context: NSManagedObjectContext) -> UserEntity {
        let entity = UserEntity(context: context)
        entity.id = self.id
        entity.userName = self.userName
        if let productsData = try? JSONEncoder().encode(self.orderedProducts) {
            entity.orderedProducts = productsData
        }
        entity.totalPrice = self.totalPrice
        return entity
    }
}
