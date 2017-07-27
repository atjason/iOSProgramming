//
//  PhotoStore.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

enum PhotosResult {
  case success([Photo])
  case failure(Error)
}

enum PhotoResult {
  case success(UIImage)
  case failure(Error)
}

enum PhotoError: Error {
  case invalidURL
  case invalidData
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
  
  func fetchPhoto(_ photo: Photo, handler: @escaping (PhotoResult) -> Void) {
    guard let url = URL(string: photo.urlString) else {
      handler(PhotoResult.failure(PhotoError.invalidURL))
      return
    }
    
    let task = session.dataTask(with: url) { (data, response, error) in
      if let data = data, let image = UIImage(data: data) {
        handler(PhotoResult.success(image))
      } else {
        let failureError = error ?? PhotoError.invalidData
        handler(PhotoResult.failure(failureError))
      }
    }
    task.resume()
  }
}
