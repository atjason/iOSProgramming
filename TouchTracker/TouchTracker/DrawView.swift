//
//  DrawView.swift
//  TouchTracker
//
//  Created by Jason Zheng on 2017/07/26.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit
import CoreGraphics

class DrawView: UIView {
  
  var currentLines = [NSValue: Line]()
  var finishedLines = [Line]()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    let doubleTapGesture = UITapGestureRecognizer()
    doubleTapGesture.numberOfTapsRequired = 2
    doubleTapGesture.addTarget(self, action: #selector(doubleTap(_:)))
    self.addGestureRecognizer(doubleTapGesture)
    
    let tapGesture = UITapGestureRecognizer()
    tapGesture.require(toFail: doubleTapGesture)
    tapGesture.delaysTouchesBegan = true
    tapGesture.addTarget(self, action: #selector(tap(_:)))
    self.addGestureRecognizer(tapGesture)
  }
  
  @IBInspectable var currentLineColor: UIColor = .red {
    didSet {
      setNeedsDisplay()
    }
  }
  
  @IBInspectable var finishedLineColor: UIColor = .black {
    didSet {
      setNeedsDisplay()
    }
  }
  
  @IBInspectable var lineThickness: CGFloat = 10.0 {
    didSet {
      setNeedsDisplay()
    }
  }
  
  // MARK: - Draw
  
  override func draw(_ rect: CGRect) {    
    finishedLineColor.setStroke()
    for line in finishedLines {
      stoke(line)
    }
    
    currentLineColor.setStroke()
    for (_, line) in currentLines {
      stoke(line)
    }
  }
  
  // MARK: - Touch Event
  
  func tap(_ sender: UIGestureRecognizer) {
    
  }
  
  func doubleTap(_ sender: UIGestureRecognizer) {
    currentLines.removeAll()
    finishedLines.removeAll()
    
    setNeedsDisplay()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let point = touch.location(in: self)
      let line = Line(start: point, end: point)
      
      let value = NSValue(nonretainedObject: touch)
      currentLines[value] = line
    }
    
    setNeedsDisplay()
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let point = touch.location(in: self)
      let value = NSValue(nonretainedObject: touch)
      currentLines[value]?.end = point
    }
    
    setNeedsDisplay()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let point = touch.location(in: self)
      let value = NSValue(nonretainedObject: touch)
      
      if var line = currentLines[value] {
        line.end = point
        finishedLines.append(line)
        
        currentLines[value] = nil
      }
    }
    
    setNeedsDisplay()
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    currentLines.removeAll()
    
    setNeedsDisplay()
  }
  
  // MARK: - Helper
  
  func stoke(_ line: Line) {
    let path = UIBezierPath()
    path.lineWidth = lineThickness
    path.lineCapStyle = .round
    
    path.move(to: line.start)
    path.addLine(to: line.end)
    
    path.stroke()
  }
}
