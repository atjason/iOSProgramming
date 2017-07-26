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
    
    let items = [
      NSLocalizedString("Standard", comment: ""),
      NSLocalizedString("Hybrid", comment: ""),
      NSLocalizedString("Satellite", comment: ""),
    ]
    let segmentedControl = UISegmentedControl(items: items)
    segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    segmentedControl.selectedSegmentIndex = 0
    
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(segmentedControl)
    
    let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
    
    let margins = view.layoutMarginsGuide
    let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
    let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
    //let leftConstraint = segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor)
    //let rightConstraint = segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor)
    
    topConstraint.isActive = true
    leadingConstraint.isActive = true
    trailingConstraint.isActive = true
    
    segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
  }
  
  // MARK: - Action
  
  @IBAction func mapTypeChanged(_ sender: UISegmentedControl!) {
    switch sender.selectedSegmentIndex {
    case 0: mapView.mapType = .standard
    case 1: mapView.mapType = .hybrid
    case 2: mapView.mapType = .satellite
    default: break
    }
  }
}
