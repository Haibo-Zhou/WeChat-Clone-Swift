//
//  Friend+CoreDataProperties.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/15.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var isMute: Bool
    @NSManaged public var name: String?
    @NSManaged public var profileImageData: Data?
    @NSManaged public var messages: NSSet?

}

// MARK: Generated accessors for messages
extension Friend {

    @objc(addMessagesObject:)
    @NSManaged public func addToMessages(_ value: Message)

    @objc(removeMessagesObject:)
    @NSManaged public func removeFromMessages(_ value: Message)

    @objc(addMessages:)
    @NSManaged public func addToMessages(_ values: NSSet)

    @objc(removeMessages:)
    @NSManaged public func removeFromMessages(_ values: NSSet)

}

extension Friend : Identifiable {

}
