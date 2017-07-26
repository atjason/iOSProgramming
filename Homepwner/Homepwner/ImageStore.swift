//
//  ImageStore.swift
//  Homepwner
//
//  Created by Jason Zheng on 2017/07/26.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class ImageStore {
  
  let cache = NSCache<NSString, UIImage>()
  
  subscript(key: String) -> UIImage? {
    get {
      return cache.object(forKey: key as NSString)
    }
    
    set {
      if let image = newValue {
        cache.setObject(image, forKey: key as NSString)
      } else {
        cache.removeObject(forKey: key as NSString)
      }
    }
  }
}


