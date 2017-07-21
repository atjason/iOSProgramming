//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Jason Zheng on 2017/07/21.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func loadView() {
    super.loadView()
    
    mapView = MKMapView()
    view = mapView
    
    let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
    segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    segmentedControl.selectedSegmentIndex = 0
    
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(segmentedControl)
    
    let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.topAnchor)
    let leftConstraint = segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor)
    let rightConstraint = segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor)
    
    topConstraint.isActive = true
    leftConstraint.isActive = true
    rightConstraint.isActive = true
  }
}
