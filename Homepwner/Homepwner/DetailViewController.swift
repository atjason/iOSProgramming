//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Jason Zheng on 2017/07/25.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var serialField: UITextField!
  @IBOutlet weak var priceField: UITextField!
  @IBOutlet weak var dateLabel: UILabel!
  
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
    
    nameField.text = item.name
    serialField.text = item.serialNumber
    priceField.text = priceFormater.string(from: NSNumber(value: item.price))
    dateLabel.text = dateFormater.string(from: item.date)
  }
}
