//
//  FlickrAPI.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import Foundation

enum Method: String {
  case interestingPhotos = "flickr.interestingness.getList"
}

struct FlickrAPI {
  private static let baseURLString = "https://api.flickr.com/services/rest"
  private static let apiKey = "a6d819499131071f158fd740860a5a88"
  
  let interestingURLString: URL = {
    let parameters = ["extra": "url_h,date_taken"]
    return FlickrAPI.flickURL(method: .interestingPhotos, parameters: nil)
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
}
