//
//  Station+CoreDataProperties.swift
//  
//
//  Created by Salomé Russier on 01/07/2018.
//
//

import Foundation
import CoreData


extension Station {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Station> {
        return NSFetchRequest<Station>(entityName: "Station")
    }

    @NSManaged public var number: Int32
    @NSManaged public var name: String?
    @NSManaged public var lastUpdate: NSDate?
    @NSManaged public var availableBike: Int32
    @NSManaged public var availableBikeStands: Int32
    @NSManaged public var bikeStands: Int32
    @NSManaged public var status: String?
    @NSManaged public var address: String?

}
