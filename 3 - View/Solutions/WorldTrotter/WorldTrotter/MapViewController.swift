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
  }
}
