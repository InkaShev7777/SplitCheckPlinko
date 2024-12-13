//
//  CoreDataManager.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    func fetchUsers() -> [User] {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            let entities = try context.fetch(fetchRequest)
            return entities.map { $0.toUser() }
        } catch {
            print("Failed to fetch users: \(error)")
            return []
        }
    }
    
    func addUser(user: User) {
        let context = PersistenceController.shared.container.viewContext
        let _ = user.toUserEntity(context: context)
        
        do {
            try context.save()
        } catch {
            print("DEBUG: Failed to save user: \(error)")
        }
    }
    
    func deleteUser(user: User) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", user.id)
        
        do {
            let entities = try context.fetch(fetchRequest)
            for entity in entities {
                context.delete(entity)
            }
            try context.save()
        } catch {
            print("Failed to delete user: \(error)")
        }
    }
    func saveContext() {
        let context = PersistenceController.shared.container.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                    print("Context saved successfully.")
                } catch {
                    print("Failed to save context: \(error)")
                }
            } else {
                print("No changes to save.")
            }
        }
    
    func updateUserName(user: User) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", user.id)
        
        do {
            let results = try context.fetch(fetchRequest)
            guard let userEntity = results.first else {
                print("User not found.")
                return
            }
            
            userEntity.userName = user.userName
            if let productsData = try? JSONEncoder().encode(user.orderedProducts) {
                userEntity.orderedProducts = productsData
            }
            
            try context.save()
            print("User updated successfully.")
        } catch {
            print("Failed to update user: \(error)")
        }
    }
}
