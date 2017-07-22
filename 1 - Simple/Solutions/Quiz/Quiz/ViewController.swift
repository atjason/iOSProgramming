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
  @IBOutlet weak var currentQuestionLabelCenterXLayout: NSLayoutConstraint!
  @IBOutlet weak var nextQuestionLabelCenterXLayout: NSLayoutConstraint!
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
    
    resetLayoutConstraint()
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
    view.layoutIfNeeded()
    
    currentQuestionLabelCenterXLayout.constant += view.frame.width
    nextQuestionLabelCenterXLayout.constant += view.frame.width
    
    UIView.animate(withDuration: 0.5, animations: { 
      self.currentQuestionLabel.alpha = 0
      self.nextQuestionLabel.alpha = 1
      
      self.view.layoutIfNeeded()
      
    }) { (result) in
      assert(result)
      
      swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
      swap(&self.currentQuestionLabelCenterXLayout, &self.nextQuestionLabelCenterXLayout)
      
      self.resetLayoutConstraint()
    }
  }
  
  func resetLayoutConstraint() {
    nextQuestionLabelCenterXLayout.constant = -view.frame.width
  }
}

