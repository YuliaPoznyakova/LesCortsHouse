//
//  Dish+CoreDataProperties.swift
//  LesCortsHouse
//
//  Created by Yulia Poznyakova on 20.06.2024.
//
//

import Foundation
import CoreData


@objc(Dish)
public class Dish: NSManagedObject {}

extension Dish {
    
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var image: String?
    @NSManaged public var notes: String?
    @NSManaged public var spicy: Bool
    @NSManaged public var isComplete: Bool
}

extension Dish: Identifiable {}

extension Dish {
    convenience init(id: UUID, title: String) {
        self.init()
        self.id = id
        self.title = title
    }
}
