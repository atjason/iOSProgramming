//
//  ItemStore.swift
//  Homepwner
//
//  Created by Jason Zheng on 2017/07/24.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import Foundation

class ItemStore {
  var items: [Item]
  
  init() {
    items = [Item]()
    
    for _ in 0..<5 {
      items.append(createItem(random: true))
    }
  }
  
  @discardableResult func createItem(random: Bool) -> Item {
    guard random else {
      return Item(name: "", price: 0)
    }
    
    let owners = ["Tom", "John", "Emily"]
    let objects = ["House", "Car", "Computer", "Phone"]
    
    let ownerIndex = randomInt(upper: owners.count)
    let owner = owners[ownerIndex]
    
    let objectIndex = randomInt(upper: objects.count)
    let object = objects[objectIndex]
    
    let name = "\(owner)'s \(object)"
    
    let price = randomInt(upper: 100)
    
    let serialNumber = UUID().uuidString.components(separatedBy: "-").first!
    
    return Item(name: name, price: price, serialNumber: serialNumber)
  }
  
  func randomInt(upper: Int) -> Int {
    return Int(arc4random_uniform(UInt32(upper)))
  }
}
