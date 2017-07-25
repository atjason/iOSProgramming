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

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    if let navigationController = window?.rootViewController as? UINavigationController,
      let itemsViewController = navigationController.topViewController as? ItemsViewController {
      itemsViewController.itemStore = ItemStore()
    }
    
    return true
  }
}

