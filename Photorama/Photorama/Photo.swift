//
//  Photo.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import Foundation

class Photo {
  var id = ""
  var title = ""
  var farm = 0
  var server = ""
  var secret = ""
  
  var urlString: String {
    let baseURL = "https://farm%d.staticflickr.com/%@/%@_%@.jpg"
    return String(format: baseURL, farm, server, id, secret)
  }
  
  init(id: String, title: String, farm: Int, server: String, secret: String) {
    self.id = id
    self.title = title
    self.farm = farm
    self.server = server
    self.secret = secret
  }
}
