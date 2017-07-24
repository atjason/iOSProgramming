//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Jason Zheng on 2017/07/24.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
  var itemStore: ItemStore!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let statusBarFrame = UIApplication.shared.statusBarFrame
    
    let insets = UIEdgeInsetsMake(statusBarFrame.height, 0, 0, 0)
    tableView.contentInset = insets
    tableView.scrollIndicatorInsets = insets
  }
  
  // MARK: - Action
  
  @IBAction func toggleEditting(_ sender: UIButton) {
    if isEditing {
      setEditing(false, animated: true)
      sender.setTitle("Edit", for: .normal)
    } else {
      setEditing(true, animated: true)
      sender.setTitle("Done", for: .normal)
    }
  }
  
  @IBAction func addItem(_ sender: UIButton) {
    
  }
  
  // MARK: - UITableViewDataSource
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemStore.items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
    
    let item = itemStore.items[indexPath.row]
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = "$\(item.price)"
    return cell
  }
}
