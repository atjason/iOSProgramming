//
//  TagsDataSource.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/28.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit
import CoreData

class TagsDataSource: NSObject, UITableViewDataSource {
  
  var tags = [Tag]()
  
  // MARK: - UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tags.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let viewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
    
    let tag = tags[indexPath.row]
    viewCell?.textLabel?.text = tag.title
    
    return viewCell
  }
}
