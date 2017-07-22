//
//  ViewController.swift
//  Quiz
//
//  Created by Jason Zheng on 2017/07/21.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var currentQuestionLabel: UILabel!
  @IBOutlet weak var nextQuestionLabel: UILabel!
  @IBOutlet weak var answerLabel: UILabel!
  
  let questions = [
    "What's your name?",
    "How old are you?",
  ]
  
  let answers = [
    "Jason",
    "99",
  ]
  
  var currentQuestionIndex = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    
    currentQuestionLabel.text = questions[currentQuestionIndex]
    
    nextQuestionLabel.alpha = 0
  }
  
  // MARK: - Action
  
  @IBAction func showNextQuestion(_ sender: UIButton) {
    let nextQuestionIndex = (currentQuestionIndex + 1 ) % questions.count
    
    nextQuestionLabel.text = questions[nextQuestionIndex]
    answerLabel.text = "???"
    
    animateLabelTranstitions()
    
    currentQuestionIndex = nextQuestionIndex
  }
  
  @IBAction func showAnswer(_ sender: UIButton) {
    answerLabel.text = answers[currentQuestionIndex]
  }
  
  // MARK: - Helper
  
  func animateLabelTranstitions() {
    UIView.animate(withDuration: 0.5, animations: { 
      self.currentQuestionLabel.alpha = 0
      self.nextQuestionLabel.alpha = 1
      
    }) { (result) in
      assert(result)
      swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
    }
  }
}

