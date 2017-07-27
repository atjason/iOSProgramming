//
//  PhotoStore.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import Foundation

enum PhotosResult {
  case success([Photo])
  case failure(Error)
}

class PhotoStore {
  
  private let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
  }()
  
  func fetchInterestingPhotos(handler: @escaping (PhotosResult) -> Void) {
    let url = FlickrAPI.interestingURLString
    let task = session.dataTask(with: url) { (data, response, error) in
      if let jsonData = data {
        let photoResult = FlickrAPI.photos(ofJSON: jsonData)
        handler(photoResult)
        
      } else if let error = error {
        handler(PhotosResult.failure(error))
      } else {
        handler(PhotosResult.failure(FlickrError.unknown))
      }
    }
    task.resume()
  }
}
