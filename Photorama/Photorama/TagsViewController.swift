//
//  TagsViewController.swift
//  Photorama
//
//  Created by Jason Zheng on 2017/07/28.
//  Copyright © 2017 Jason Zheng. All rights reserved.
//

import UIKit
import CoreData

class TagsViewController: UITableViewController {
  
  var photo: Photo!
  var photoStore: PhotoStore!
  let tagsDataSource = TagsDataSource()
  var selectedIndexPaths = [IndexPath]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = tagsDataSource
    
    updateTags()
  }
  
  // MARK: - Action
  
  @IBAction func addTag(_ sender: UIBarButtonItem) {
    let alert = UIAlertController()
    alert.title = "Add Tag"
    
    alert.addTextField { (textField) in
      textField.placeholder = "Tag title"
    }
    
    let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
      guard let title = alert.textFields?.first?.text else {
        return
      }
      
//      Tag.init(entity: NSEntityDescription.init, insertInto: )
      
      // TODO Selected new added tag.
      
      self.photoStore.save()
      
      self.updateTags()
    }
    alert.addAction(addAction)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func done(_ sender: UIBarButtonItem) {
    presentingViewController?.dismiss(animated: true, completion: nil)
  }
  
  // MARK: - UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    // TODO Update selected status
    cell.isSelected = (selectedIndexPaths.index(of: indexPath) != nil)
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let indexPathIndex = selectedIndexPaths.index(of: indexPath) {
      let tag = tagsDataSource.tags[indexPath.row]
      let mutableTags = NSMutableSet(set: photo.tags!)
      mutableTags.remove(tag)
      photo.tags = mutableTags
      
      selectedIndexPaths.remove(at: indexPathIndex)
      
      // TODO Update selected status
      
    } else {
      let tag = tagsDataSource.tags[indexPath.row]
      photo.tags?.adding(tag)
      
      selectedIndexPaths.append(indexPath)
      
      // TODO Update selected status
    }
  }
  
  // MARK: - Helper
  
  func updateTags() {
    photoStore.fetchAllTags { (tagsResult) in
      if case let .success(tags) = tagsResult {
        self.tagsDataSource.tags = tags
        
        self.selectedIndexPaths.removeAll()
        for tag in self.photo.tags! { // TODO
          if let index = tags.index(of: tag as! Tag) { // TODO as!
            let indexPath = IndexPath(row: index, section: 0)
            self.selectedIndexPaths.append(indexPath)
          }
        }
        
        OperationQueue.main.addOperation {
          self.tableView.reloadData()
        }
      }
    }
  }
}
