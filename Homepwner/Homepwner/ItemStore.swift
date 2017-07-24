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
      items.append(Item(random: true))
    }
  }
  
  @discardableResult func createItem() -> Item {
    let item = Item(random: true)
    
    items.append(item)
    
    return item
  }
}
