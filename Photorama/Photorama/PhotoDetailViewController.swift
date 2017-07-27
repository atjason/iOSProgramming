//
//  PhotoDetailViewController.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
  
  @IBOutlet var imageView: UIImageView!
  
  var photo: Photo! {
    didSet {
      navigationItem.title = photo.title
    }
  }
  
  var photoStore: PhotoStore!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    photoStore.fetchPhoto(photo) { (photoResult) in
      if case let .success(image) = photoResult {
        OperationQueue.main.addOperation {
          self.imageView.image = image
        }
      }
    }
  }
}
