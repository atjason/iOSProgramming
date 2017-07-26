//
//  AppDelegate.swift
//  Homepwner
//
//  Created by Jason Zheng on 2017/07/24.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  let itemStore = ItemStore()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let imageStore = ImageStore()
    
    if let navigationController = window?.rootViewController as? UINavigationController,
      let itemsViewController = navigationController.topViewController as? ItemsViewController {
      itemsViewController.itemStore = itemStore
      itemsViewController.imageStore = imageStore
    }
    
    return true
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    let result = itemStore.save()
    assert(result)
  }
}

