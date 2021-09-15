//
//  Thumbnail+CoreDataProperties.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/15.
//
//

import Foundation
import CoreData


extension Thumbnail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Thumbnail> {
        return NSFetchRequest<Thumbnail>(entityName: "Thumbnail")
    }

    @NSManaged public var id: Double
    @NSManaged public var imageData: Data?
    @NSManaged public var message: Message?

}

extension Thumbnail : Identifiable {

}
