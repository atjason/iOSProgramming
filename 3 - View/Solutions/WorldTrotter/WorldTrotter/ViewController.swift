//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Jason Zheng on 2017/07/21.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var celsiusLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    celsiusLabel.text = "???"
  }
  
  @IBAction func fahrenheitChanged(_ sender: UITextField) {
    if let text = sender.text {
      celsiusLabel.text = text
    } else {
      celsiusLabel.text = "???"
    }
  }
}

