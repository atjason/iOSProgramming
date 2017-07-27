//
//  PhotoStore.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import Foundation

enum PhotoResult {
  case success([Photo])
  case failure(Error)
}

class PhotoStore {
  
  private let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
  }()
  
  func fetchInterestingPhotos(hander: @escaping (PhotoResult) -> Void) {
    let url = FlickrAPI.interestingURLString
    let task = session.dataTask(with: url) { (data, response, error) in
      if let jsonData = data {
        let str = String(data: jsonData, encoding: .utf8)
        print(str)
      } else if let error = error {
        print(error)
      } else {
        assert(false, "Unexpected error.")
      }
    }
    task.resume()
  }
}
