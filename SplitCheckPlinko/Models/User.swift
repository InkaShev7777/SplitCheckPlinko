//
//  User.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import Foundation
import CoreData

class User: Identifiable {
    
    init(userName: String) {
        self.id = UUID().uuidString
        self.userName = userName
    }
    
    var id: String
    var userName: String
    
}

extension UserEntity {
    func toUser() -> User {
        return User(userName: userName ?? "")
    }
}

extension User {
    func toUserEntity(context: NSManagedObjectContext) -> UserEntity {
        let entity = UserEntity(context: context)
        entity.id = self.id
        entity.userName = self.userName
        return entity
    }
}
