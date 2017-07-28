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
    
    tableView.delegate = self
    tableView.dataSource = tagsDataSource
    
    updateTags()
  }
  
  // MARK: - Action
  
  @IBAction func addTag(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "Add Tag", message: nil, preferredStyle: .alert)
    
    alert.addTextField { (textField) in
      textField.placeholder = "Tag title"
      textField.autocapitalizationType = .words
    }
    
    let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
      guard let title = alert.textFields?.first?.text else {
        return
      }
      
      let context = self.photoStore.persistentContainer.viewContext
      let newTag = NSEntityDescription.insertNewObject(forEntityName: "Tag", into: context)
      newTag.setValue(title, forKey: "title")
      
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
    if selectedIndexPaths.index(of: indexPath) != nil {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let tag = tagsDataSource.tags[indexPath.row]
    
    if let index = selectedIndexPaths.index(of: indexPath) {
      selectedIndexPaths.remove(at: index)
      photo.removeFromTags(tag)
    } else {
      selectedIndexPaths.append(indexPath)
      photo.addToTags(tag)
    }
    
    photoStore.save()
    
    tableView.reloadRows(at: [indexPath], with: .automatic)
  }
  
  // MARK: - Helper
  
  func updateTags() {
    photoStore.fetchAllTags { (tagsResult) in
      if case let .success(tags) = tagsResult {
        self.tagsDataSource.tags = tags
        
        if let photoTags = self.photo.tags as? Set<Tag> {
          self.selectedIndexPaths.removeAll()
          for tag in photoTags {
            if let index = tags.index(of: tag) {
              let indexPath = IndexPath(row: index, section: 0)
              self.selectedIndexPaths.append(indexPath)
            }
          }
        }
        
        OperationQueue.main.addOperation {
          self.tableView.reloadData()
        }
      }
    }
  }
}
