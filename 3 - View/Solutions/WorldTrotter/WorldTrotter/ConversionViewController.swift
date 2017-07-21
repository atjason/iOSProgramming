//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Jason Zheng on 2017/07/21.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var fahrenheitTextField: UITextField!
  @IBOutlet weak var celsiusLabel: UILabel!
  
  var fahrenheitValue: Measurement<UnitTemperature>? {
    didSet {
      updateCelsius()
    }
  }
  
  var celsiusValue: Measurement<UnitTemperature>? {
    if let fahrenheitValue = fahrenheitValue {
      return fahrenheitValue.converted(to: .celsius)
    } else {
      return nil
    }
  }
  
  let numberFormater: NumberFormatter = {
    let numberFormater = NumberFormatter()
    numberFormater.numberStyle = .decimal
    numberFormater.minimumFractionDigits = 0
    numberFormater.maximumFractionDigits = 1
    return numberFormater
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateCelsius()
    
    //fahrenheitTextField.becomeFirstResponder()
  }
  
  // MARK: - Action
  
  @IBAction func fahrenheitChanged(_ sender: UITextField) {
    if let text = sender.text, let value = Double(text) {
      fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
    } else {
      fahrenheitValue = nil
    }
  }
  
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    fahrenheitTextField.resignFirstResponder()
  }
  
  // MARK: - UITextFieldDelegate
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard isDecimalString(string) else {
      return false
    }
    
    let alreadyHasDecimalSeperator = (textField.text?.contains(".") == true)
    let newStringHasDecimalSeperator = string.contains(".")
    
    //NSCharacterSet.decimalDigits
    
    if alreadyHasDecimalSeperator && newStringHasDecimalSeperator {
      return false
    } else {
      return true
    }
  }
  
  // MARK: - Helper
  
  func updateCelsius() {
    if let celsiusValue = celsiusValue {
      celsiusLabel.text = numberFormater.string(from: NSNumber(value: celsiusValue.value))
    } else {
      celsiusLabel.text = "???"
    }
  }
  
  func isDecimalString(_ str: String) -> Bool {
    var notDigits = NSCharacterSet.decimalDigits.inverted
    notDigits.remove(".")
    return (str.rangeOfCharacter(from: notDigits) == nil)
  }
}

