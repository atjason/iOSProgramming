//
//  Photo+CoreDataClass.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/28.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import Foundation
import CoreData

@objc(Photo)
public class Photo: NSManagedObject {
  
  static func generateURL(id: String, farm: Int, server: String, secret: String) -> URL {
    let baseURL = "https://farm%d.staticflickr.com/%@/%@_%@.jpg"
    let urlString = String(format: baseURL, farm, server, id, secret)
    return URL(string: urlString)!
  }
}
