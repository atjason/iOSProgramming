//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class PhotosViewController: UICollectionViewController {
  
//  var photoStore: PhotoStore!
  
  var photoDataSource: PhotoDataSource!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.dataSource = photoDataSource
    
//    photoStore.fetchInterestingPhotos { (photosResult) in
//      switch photosResult {
//      case let .success(photos):
//        print("Get \(photos.count) photos.")
//        
//        if let photo = photos.first {
//          self.fetchAndDisplay(photo: photo)
//        }
//        
//      case let .failure(error):
//        print("Get error: \(error.localizedDescription)")
//      }
//    }
  }
  
  // MARK: - Helper
  
//  func fetchAndDisplay(photo: Photo) {
//    photoStore.fetchPhoto(photo, handler: { (photoResult) in
//      switch photoResult {
//      case let .success(image):
//        OperationQueue.main.addOperation {
//          self.imageView.image = image
//        }
//      case let .failure(error):
//        print(error)
//      }
//    })
//  }
}
