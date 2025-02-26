//
//  Stat+CoreDataProperties.swift
//  Memory Sparks
//
//  Created by Hosein Darabi on 12/12/24.
//
//

import Foundation
import CoreData


extension Stat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stat> {
        return NSFetchRequest<Stat>(entityName: "Stat")
    }

    @NSManaged public var completedPrompts: Int32
    @NSManaged public var totalPrompts: Int32
    @NSManaged public var streak: Int16
    @NSManaged public var wordsWritten: Int32
    @NSManaged public var lastActiveDate: Date?

}

extension Stat : Identifiable {

}
