//
//  Contact+CoreDataProperties.swift
//  
//
//  Created by Patrick Kalkman on 10/05/2019.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var firstname: String?
    @NSManaged public var status: String?
    @NSManaged public var group: String?
    @NSManaged public var lastname: String?
    @NSManaged public var phones: NSSet?
    @NSManaged public var emails: NSSet?

}

// MARK: Generated accessors for phones
extension Contact {

    @objc(addPhonesObject:)
    @NSManaged public func addToPhones(_ value: Phone)

    @objc(removePhonesObject:)
    @NSManaged public func removeFromPhones(_ value: Phone)

    @objc(addPhones:)
    @NSManaged public func addToPhones(_ values: NSSet)

    @objc(removePhones:)
    @NSManaged public func removeFromPhones(_ values: NSSet)

}

// MARK: Generated accessors for emails
extension Contact {

    @objc(addEmailsObject:)
    @NSManaged public func addToEmails(_ value: Email)

    @objc(removeEmailsObject:)
    @NSManaged public func removeFromEmails(_ value: Email)

    @objc(addEmails:)
    @NSManaged public func addToEmails(_ values: NSSet)

    @objc(removeEmails:)
    @NSManaged public func removeFromEmails(_ values: NSSet)

}
