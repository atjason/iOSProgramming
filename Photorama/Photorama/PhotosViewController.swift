//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
  
  @IBOutlet var imageView: UIImageView!
  
  var photoStore: PhotoStore!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    photoStore.fetchInterestingPhotos { (photoResult) in
      switch photoResult {
      case let .success(photos):
        print("Get \(photos.count) photos.")
      case let .failure(error):
        print("Get error: \(error.localizedDescription)")
      }
    }
  }
}
