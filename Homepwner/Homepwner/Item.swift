//
//  Item.swift
//  Homepwner
//
//  Created by Jason Zheng on 2017/07/24.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class Item: NSObject {
  var name: String
  var price: Int
  var serialNumber: String?
  var date: Date
  
  init(name: String, price: Int, serialNumber: String? = nil) {
    self.name = name
    self.price = price
    self.serialNumber = serialNumber
    self.date = Date()
    
    super.init()
  }
}
