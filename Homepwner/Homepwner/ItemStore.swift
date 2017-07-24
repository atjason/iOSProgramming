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
  
  func move(sourceIndex: Int, destinationIndex: Int) {
    guard sourceIndex != destinationIndex
      && sourceIndex >= 0 && sourceIndex < items.count
      && destinationIndex >= 0 && destinationIndex < items.count else {
      return
    }
    
    let item = items.remove(at: sourceIndex)
    items.insert(item, at: destinationIndex)
  }
}
