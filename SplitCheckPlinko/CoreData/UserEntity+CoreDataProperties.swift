//
//  UserEntity+CoreDataProperties.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 13.12.2024.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var userName: String?
    @NSManaged public var orderedProducts: Data?

}

extension UserEntity : Identifiable {

}
