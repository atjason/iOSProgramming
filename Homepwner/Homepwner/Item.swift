//
//  Item.swift
//  Homepwner
//
//  Created by Jason Zheng on 2017/07/24.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class Item: NSObject {
  var id: String
  var name: String
  var price: Int
  var serialNumber: String?
  var date: Date
  
  init(name: String, price: Int, serialNumber: String? = nil) {
    self.id = UUID().uuidString
    self.name = name
    self.price = price
    self.serialNumber = serialNumber
    self.date = Date()
    
    super.init()
  }
  
  convenience init(random: Bool) {
    guard random else {
      self.init(name: "", price: 0)
      return
    }
    
    let owners = ["Tom", "John", "Emily"]
    let objects = ["House", "Car", "Computer", "Phone"]
    
    let ownerIndex = Item.randomInt(upper: owners.count)
    let owner = owners[ownerIndex]
    
    let objectIndex = Item.randomInt(upper: objects.count)
    let object = objects[objectIndex]
    
    let name = "\(owner)'s \(object)"
    
    let price = Item.randomInt(upper: 100)
    
    let serialNumber = UUID().uuidString.components(separatedBy: "-").first!
    
    self.init(name: name, price: price, serialNumber: serialNumber)
  }
  
  static func randomInt(upper: Int) -> Int {
    return Int(arc4random_uniform(UInt32(upper)))
  }
}
