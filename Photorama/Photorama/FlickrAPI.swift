//
//  FlickrAPI.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import CoreData
import Foundation

enum Method: String {
  case interestingPhotos = "flickr.interestingness.getList"
}

enum FlickrError: Error {
  case invalidJSON
  case unknown
}

struct FlickrAPI {
  private static let baseURLString = "https://api.flickr.com/services/rest"
  private static let apiKey = "a6d819499131071f158fd740860a5a88"
  
  static let interestingURLString: URL = {
    let parameters = ["extra": "url_h,date_taken"]
    return flickURL(method: .interestingPhotos, parameters: nil)
  }()
  
  private static func flickURL(method: Method, parameters: [String: String]?) -> URL {
    var components = URLComponents(string: FlickrAPI.baseURLString)!
    
    var queryItems = [URLQueryItem]()
    
    var params: [String: String] = [
      "method": method.rawValue,
      "format": "json",
      "nojsoncallback": "1",
      "api_key": apiKey
    ]
    
    if let additionalParams = parameters {
      // TODO Merge to dictionary
      for (key, value) in additionalParams {
        params[key] = value
      }
    }
    
    for (key, value) in params {
      let item = URLQueryItem(name: key, value: value)
      queryItems.append(item)
    }
    
    components.queryItems = queryItems
    
    return components.url!
  }
  
  static func photos(ofJSON jsonData: Data, into context: NSManagedObjectContext) -> PhotosResult {
    
    guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
      let photosJSON = json?["photos"] as? [String: Any],
      let photoDataList = photosJSON["photo"] as? [[String: Any]] else {
        return PhotosResult.failure(FlickrError.invalidJSON)
    }
    
    var photos = [Photo]()
    for photoData in photoDataList {
      if let photo = photo(ofJSON: photoData, into: context) {
        photos.append(photo)
      }
    }
    
    if !photoDataList.isEmpty && photos.isEmpty {
      return PhotosResult.failure(FlickrError.invalidJSON)
    }
    
    return PhotosResult.success(photos)
  }
  
  private static func photo(ofJSON json: [String: Any], into context: NSManagedObjectContext) -> Photo? {
    guard let id = json["id"] as? String,
      let title = json["title"] as? String,
      let farm = json["farm"] as? Int,
      let server = json["server"] as? String,
      let secret = json["secret"] as? String else {
      return nil
    }
    
    // Fetch photo from Core Data if exsiting.
    
    var photos: [Photo]?
    let request: NSFetchRequest<Photo> = Photo.fetchRequest()
    request.predicate = NSPredicate(format: "\(#keyPath(Photo.id)) == \(id)")
    context.performAndWait {
      photos = try? context.fetch(request)
    }
    if let existingPhoto = photos?.first {
      return existingPhoto
    }
    
    // Generate new photo and insert into Core Data.
    
    let url = Photo.generateURL(id: id, farm: farm, server: server, secret: secret)
    
    var photo: Photo!
    context.performAndWait {
      photo = Photo(context: context)
      photo.id = id
      photo.title = title
      photo.url = url as NSURL
      photo.times = 0
    }
    
    return photo
  }
}
