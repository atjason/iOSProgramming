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

  func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    print(#function)
    return true
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    print(#function)
    
    let imageStore = ImageStore()
    
    if let navigationController = window?.rootViewController as? UINavigationController,
      let itemsViewController = navigationController.topViewController as? ItemsViewController {
      itemsViewController.itemStore = itemStore
      itemsViewController.imageStore = imageStore
    }
    
    return true
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    print(#function)
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    print(#function)
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    print(#function)
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    let result = itemStore.save()
    assert(result)
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    print(#function)
  }
}

