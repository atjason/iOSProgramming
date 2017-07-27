//
//  PhotoViewCell.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/27.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class PhotoViewCell: UICollectionViewCell {
  
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var indicator: UIActivityIndicatorView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    update(with: nil)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    update(with: nil)
  }
  
  // MARK: - Helper
  
  func update(with image: UIImage?) {
    if let image = image {
      imageView.image = image
      indicator.stopAnimating()
      
    } else {
      imageView.image = nil
      indicator.startAnimating()
    }
  }
}
