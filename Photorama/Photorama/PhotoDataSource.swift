//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource {
  
  var photoStore: PhotoStore!
  
  var photos = [Photo]()
  
  // MARK: - Public Method
  
  func loadPhotos(handler: @escaping () -> Void) {
    photoStore.fetchInterestingPhotos { (photosResult) in
      if case let .success(photos) = photosResult {
        self.photos = photos
      }
      
      handler()
    }
  }
  
  // MARK: - UICollectionViewDataSource
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let photoViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as! PhotoViewCell
    return photoViewCell
  }
}
