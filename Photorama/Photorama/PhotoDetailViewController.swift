//
//  PhotoDetailViewController.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit
import CoreData

class PhotoDetailViewController: UIViewController {
  
  @IBOutlet var timesLabel: UILabel!
  @IBOutlet var imageView: UIImageView!
  
  var photo: Photo!
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationItem.title = photo.title
    
    photo.times += 1
    photoStore.save()
    
    timesLabel.text = "\(photo.times)"
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showTags"?:
      if let navigationController = segue.destination as? UINavigationController,
        let tagsViewContoller = navigationController.topViewController as? TagsViewController {
        tagsViewContoller.photo = photo
        tagsViewContoller.photoStore = photoStore
      }
    default:
      preconditionFailure("Invalid segue identifier.")
    }
  }
}
