//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class PhotosViewController: UICollectionViewController {
  
  var photoStore: PhotoStore!
  
  var photoDataSource: PhotoDataSource! {
    didSet {
      collectionView?.dataSource = photoDataSource
      
      photoDataSource.loadPhotos {
        OperationQueue.main.addOperation {
          self.collectionView?.reloadData()
        }
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.delegate = self
  }
  
  // MARK: - UICollectionViewDelegate
  
  override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let photoViewCell = cell as? PhotoViewCell else {
      assert(false)
    }
    
    let photo = photoDataSource.photos[indexPath.row]
    photoStore.fetchPhoto(photo) { (photoResult) in
      // TODO Use if let
      switch photoResult {
      case let .success(image):
        OperationQueue.main.addOperation {
          photoViewCell.update(with: image)
        }
        
      default:
        break
      }
    }
  }
  
  // MARK: - Helper
  
}
