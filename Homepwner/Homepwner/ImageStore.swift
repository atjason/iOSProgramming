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
      if let image = cache.object(forKey: key as NSString) {
        return image
      }
      
      let url = imageURL(forKey: key)
      if let image = UIImage(contentsOfFile: url.path) {
        cache.setObject(image, forKey: key as NSString)
        return image
      }
      
      return nil
    }
    
    set {
      if let image = newValue {
        cache.setObject(image, forKey: key as NSString)
        
        if let data = UIImageJPEGRepresentation(image, 0.5) {
          let url = imageURL(forKey: key)
          let _ = try? data.write(to: url, options: .atomicWrite)
        }
        
      } else {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        try? FileManager.default.removeItem(at: url)
      }
    }
  }
  
  func imageURL(forKey key: String) -> URL {
    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return documents.first!.appendingPathComponent(key)
  }
}


