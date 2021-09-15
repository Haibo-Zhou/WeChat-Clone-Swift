//
//  Message+CoreDataProperties.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/15.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var isSender: Bool
    @NSManaged public var imageData: Data?
    @NSManaged public var friend: Friend?
    @NSManaged public var thumbnail: Thumbnail?

}

extension Message : Identifiable {

}
