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
  var url: URL
  
  init(id: String, title: String, url: URL) {
    self.id = id
    self.title = title
    self.url = url
  }
  
  static func generateURL(id: String, farm: Int, server: String, secret: String) -> URL {
    let baseURL = "https://farm%d.staticflickr.com/%@/%@_%@.jpg"
    let urlString = String(format: baseURL, farm, server, id, secret)
    return URL(string: urlString)!
  }
}

extension Photo: Equatable {
  static func ==(left: Photo, right: Photo) -> Bool {
    return (left.id == right.id)
  }
}
