//
//  Phone+CoreDataProperties.swift
//  
//
//  Created by Patrick Kalkman on 10/05/2019.
//
//

import Foundation
import CoreData


extension Phone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Phone> {
        return NSFetchRequest<Phone>(entityName: "Phone")
    }

    @NSManaged public var phone: String?
    @NSManaged public var type: String?
    @NSManaged public var phoneOwner: Contact?

}
