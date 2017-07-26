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
  let archivePath: String = {
    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let filename = "item.archive"
    return documents.first!.appendingPathComponent(filename).path
  }()
  
  init() {
    if let items = NSKeyedUnarchiver.unarchiveObject(withFile: archivePath) as? [Item] {
      self.items = items
    } else {
      items = [Item]()
    }
  }
  
  @discardableResult func createItem() -> Item {
    let item = Item(random: true)
    
    items.append(item)
    
    return item
  }
  
  // MARK: - Public Method
  
  func save() -> Bool {
    return NSKeyedArchiver.archiveRootObject(items, toFile: archivePath)
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
