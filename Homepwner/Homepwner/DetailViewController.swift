//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Jason Zheng on 2017/07/25.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var serialField: UITextField!
  @IBOutlet weak var priceField: UITextField!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  var item: Item!
  
  let priceFormater: NumberFormatter = {
    let formater = NumberFormatter()
    
    formater.numberStyle = .decimal
    formater.minimumFractionDigits = 2
    formater.maximumFractionDigits = 2
    
    return formater
  }()
  
  let dateFormater: DateFormatter = {
    let formater = DateFormatter()
    
    formater.dateStyle = .medium
    formater.timeStyle = .none
    
    return formater
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationItem.title = item.name
    
    nameField.text = item.name
    serialField.text = item.serialNumber
    priceField.text = priceFormater.string(from: NSNumber(value: item.price))
    dateLabel.text = dateFormater.string(from: item.date)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    view.endEditing(false)
    
    item.name = nameField.text ?? ""
    item.serialNumber = serialField.text
    if let text = priceField.text, let price = Int(text) {
      item.price = price
    } else {
      item.price = 0
    }
  }
  
  // MARK: - Action
  
  @IBAction func takePhoto(_ sender: UIBarButtonItem) {
    let imagePicker = UIImagePickerController()
    
    imagePicker.delegate = self
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      imagePicker.sourceType = .camera
    } else {
      imagePicker.sourceType = .savedPhotosAlbum
    }
    
    present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
    view.endEditing(false)
  }
  
  // MARK: - UIImagePickerControllerDelegate
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      imageView.image = image
    }
    
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  // MARK: - UITextFieldDelegate
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
