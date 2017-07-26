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
  
  @IBInspectable var currentLineColor = UIColor.red
  @IBInspectable var finishedLineColor = UIColor.black
  
  @IBInspectable var lineThickness: CGFloat = 10.0
  
  // MARK: - Draw
  
  override func draw(_ rect: CGRect) {
    currentLineColor.setStroke()
    for (_, line) in currentLines {
      stoke(line)
    }
    
    finishedLineColor.setStroke()
    for line in finishedLines {
      stoke(line)
    }
  }
  
  // MARK: - Touch Event
  
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
    for touch in touches {
      let value = NSValue(nonretainedObject: touch)
      currentLines[value] = nil
    }
    
    setNeedsDisplay()
  }
  
  // MARK: - Helper
  
  func stoke(_ line: Line) {
    let path = UIBezierPath()
    path.lineWidth = lineThickness
    
    path.move(to: line.start)
    path.addLine(to: line.end)
    
    path.stroke()
  }
}
