//
//  Location+CoreDataProperties.swift
//  MobiquityAssignment
//
//  Created by MAC on 16/08/21.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var address: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?

}

extension Location : Identifiable {

}
