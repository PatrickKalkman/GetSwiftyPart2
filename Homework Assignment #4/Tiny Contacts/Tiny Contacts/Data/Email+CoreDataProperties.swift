//
//  Email+CoreDataProperties.swift
//  
//
//  Created by Patrick Kalkman on 10/05/2019.
//
//

import Foundation
import CoreData


extension Email {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Email> {
        return NSFetchRequest<Email>(entityName: "Email")
    }

    @NSManaged public var email: String?
    @NSManaged public var type: String?
    @NSManaged public var emailOwner: Contact?

}
