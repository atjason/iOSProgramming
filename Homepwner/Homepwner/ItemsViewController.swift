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
    let item = itemStore.createItem()
    if let index = itemStore.items.index(of: item) {
      let indexPath = IndexPath(row: index, section: 0)
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
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
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    itemStore.move(sourceIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let item = itemStore.items[indexPath.row]
      let title = "Delete \(item.name)?"
      let message = "Are you sure you want to delete this item?"
      let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alert.addAction(cancelAction)
      
      let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
        self.itemStore.items.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      })
      alert.addAction(deleteAction)
      
      present(alert, animated: true, completion: nil)
    }
  }
}
