//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/28.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var url: NSURL?
    @NSManaged public var times: Int32

}
