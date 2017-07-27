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
    let photo = photoDataSource.photos[indexPath.row]
    photoStore.fetchPhoto(photo) { (photoResult) in
      if case let .success(image) = photoResult,
        let photoIndex = self.photoDataSource.photos.index(of: photo) {
        
        OperationQueue.main.addOperation {
          let indexPath = IndexPath(row: photoIndex, section: 0)
          if let photoViewCell = self.collectionView?.cellForItem(at: indexPath)as? PhotoViewCell {
            photoViewCell.update(with: image)
          }
        }
      }
    }
  }
  
  // MARK: - Segure
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "showPhoto" else {
      preconditionFailure("Invalid segue identifier: " + (segue.identifier ?? ""))
    }
    
    if let photoView = segue.destination as? PhotoDetailViewController,
      let index = collectionView?.indexPathsForSelectedItems?.first?.row {
      
      photoView.photo = photoDataSource.photos[index]
      photoView.photoStore = photoStore
    }
  }
  
  // MARK: - Helper
  
}
