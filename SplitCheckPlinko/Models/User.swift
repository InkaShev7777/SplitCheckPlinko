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
    var orderedProducts: [OrderedProduct]?
    
    init(userName: String) {
        self.id = UUID().uuidString
        self.userName = userName
        self.orderedProducts = [OrderedProduct(name: "test", price: 1, count: 1)]
    }
}

extension UserEntity {
    func toUser() -> User {
        let user = User(userName: userName ?? "")
        if let productsData = self.orderedProducts,
           let products = try? JSONDecoder().decode([OrderedProduct].self, from: productsData) {
            user.orderedProducts = products
        }
        return user
    }
}


extension User {
    func toUserEntity(context: NSManagedObjectContext) -> UserEntity {
        let entity = UserEntity(context: context)
        entity.id = self.id
        entity.userName = self.userName
        if let products = self.orderedProducts,
           let productsData = try? JSONEncoder().encode(products) {
            entity.orderedProducts = productsData
        }
        return entity
    }
}
