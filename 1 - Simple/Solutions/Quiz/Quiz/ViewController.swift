//
//  ViewController.swift
//  Quiz
//
//  Created by Jason Zheng on 2017/07/21.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var questionLabel: UILabel!
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
    
    questionLabel.text = questions[currentQuestionIndex]
  }
  
  @IBAction func showNextQuestion(_ sender: UIButton) {
    currentQuestionIndex = (currentQuestionIndex + 1 ) % questions.count
    
    questionLabel.text = questions[currentQuestionIndex]
    answerLabel.text = "???"
  }
  
  @IBAction func showAnswer(_ sender: UIButton) {
    answerLabel.text = answers[currentQuestionIndex]
  }
}

