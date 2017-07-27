//
//  AppDelegate.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var photoStore = PhotoStore()
  var photoDataSource = PhotoDataSource()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    if let photosViewController = window?.rootViewController as? PhotosViewController {
      photosViewController.photoDataSource = photoDataSource
      
      // TODO Reload photo in data source.
    }
    
    return true
  }
}

