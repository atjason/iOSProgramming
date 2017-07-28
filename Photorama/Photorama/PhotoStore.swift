//
//  PhotoStore.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit
import CoreData

enum PhotosResult {
  case success([Photo])
  case failure(Error)
}

enum TagsResult {
  case success([Tag])
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
  
  var imageStore = ImageStore()
  let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Photorama")
    container.loadPersistentStores(completionHandler: { (description, error) in
      if let error = error {
        preconditionFailure("Failed to load persistent store with error: \(error.localizedDescription)")
      }
    })
    return container
  }()
  
  private let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
  }()
  
  func fetchAllPhotos(handler: @escaping (PhotosResult) -> Void) {
    let request: NSFetchRequest<Photo> = Photo.fetchRequest()
    
//    let sortDescriptor = NSSortDescriptor(key: #keyPath(Photo.id), ascending: true)
//    request.sortDescriptors = [sortDescriptor]
    
    let context = persistentContainer.viewContext
    context.perform {
      do {
        let photos = try context.fetch(request)
        handler(.success(photos))
      } catch {
        handler(.failure(error))
      }
    }
  }
  
  func fetchAllTags(handler: @escaping (TagsResult) -> Void) {
    let request: NSFetchRequest<Tag> = Tag.fetchRequest()
    
    let sortDescriptor = NSSortDescriptor(key: #keyPath(Tag.title), ascending: true)
    request.sortDescriptors = [sortDescriptor]
    
    let context = persistentContainer.viewContext
    context.perform {
      do {
        let tags = try context.fetch(request)
        handler(TagsResult.success(tags))
      } catch {
        handler(TagsResult.failure(error))
      }
    }
  }
  
  func fetchInterestingPhotos(handler: @escaping (PhotosResult) -> Void) {
    let url = FlickrAPI.interestingURLString
    let task = session.dataTask(with: url) { (data, response, error) in
      if let jsonData = data {
        let photoResult = FlickrAPI.photos(ofJSON: jsonData, into: self.persistentContainer.viewContext)
        if case .success(_) = photoResult {
          self.save()
        }
        handler(photoResult)
        
      } else if let error = error {
        handler(.failure(error))
      } else {
        handler(.failure(FlickrError.unknown))
      }
    }
    task.resume()
  }
  
  func fetchPhoto(_ photo: Photo, handler: @escaping (PhotoResult) -> Void) {
    guard let photoID = photo.id else {
      preconditionFailure("Need photo id to continue.")
    }
    
    if let image = imageStore[photoID] {
      handler(PhotoResult.success(image))
      return
    }
    
    guard let photoURL = photo.url else {
      preconditionFailure("Need photo id to continue.")
    }
    
    let task = session.dataTask(with: photoURL as URL) { (data, response, error) in
      if let data = data, let image = UIImage(data: data) {
        self.imageStore[photoID] = image
        handler(PhotoResult.success(image))
      } else {
        let failureError = error ?? PhotoError.invalidData
        handler(PhotoResult.failure(failureError))
      }
    }
    task.resume()
  }
  
  func save() {
    do {
      try persistentContainer.viewContext.save()
    } catch {
      assert(false)
    }
  }
}
