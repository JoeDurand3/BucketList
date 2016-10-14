//
//  BucketListViewController.swift
//  BucketList
//
//  Created by Joe Durand on 10/13/16.
//  Copyright © 2016 Cal Poly App Dev. All rights reserved.
//

import Foundation
import UIKit

class BucketListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addItemButton: UIBarButtonItem!
    @IBOutlet weak var deleteItemButton: UIBarButtonItem!
    @IBOutlet weak var bucketTable: UITableView!
    
    var bucketList: [BucketListItem] = []
    
    override func viewDidLoad() {
        
        //set the title for the navigation view controller
        self.title = "Bucket List"
        
        //get rid of the pesky white space at the top of the screen
        self.automaticallyAdjustsScrollViewInsets = false
        
        //setup the add item button to call the addItem() function
        addItemButton.target = self
        addItemButton.action = #selector(BucketListViewController.addItem)
        
        //setup the delete item button to call the deleteItem() function
        deleteItemButton.target = self
        deleteItemButton.action = #selector(BucketListViewController.deleteItem)
        
        //tell the bucketTable to be controlled and get it's data from here
        bucketTable.delegate = self
        bucketTable.dataSource = self
    }
    
    /**
     Prompts the user to add an item to the bucket list, and update the table.
    */
    func addItem() {
        
        //create a UIAlertController that we will show the user
        let anAlertVC: UIAlertController = UIAlertController(title: "Add an Item", message: "What do you want to do in your life?", preferredStyle: .alert)
        
        //add a text field to the alert
        anAlertVC.addTextField(configurationHandler: { field in
            field.placeholder = "Adopt a Cat"
        })
        
        /**create an action called "Add" with a completion handler function.
            the completion handler function is called when the action happens,
            in this case when the user clicks the button. Remember that here,
            we are passing the function as an argument! */
        let addItemAction = UIAlertAction(title: "Add", style: .default, handler:
            {action in
                //if the name isn't empty, create a new item, add it to the list,
                //and update the table
                if let name = anAlertVC.textFields?.first?.text, !name.isEmpty {
                    let newItem: BucketListItem = BucketListItem(name: name, timestamp: NSDate())
                    self.bucketList.append(newItem)
                    self.bucketTable.reloadData()
            }
        })
        
        //add the addAction to the alert
        anAlertVC.addAction(addItemAction)
        
        //give the user a cancel option (in this case, we don't need a completion handler)
        anAlertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //now that we have this fancy alert setup, lets give it to the user!
        self.present(anAlertVC, animated: true, completion: nil)
    }
    
    /**
     Deletes the selected record from the bucket list, and updates the table.
    */
    func deleteItem() {
        if let index = bucketTable.indexPathForSelectedRow?.row {
            bucketList.remove(at: index)
            bucketTable.reloadData()
        }
    }
    
    /**
     The tableview asks, "What cell should I stick in this row?" and we
        answer with this function; we create a cell, label it, and return it.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = bucketList[indexPath.row].name
        return cell
    }
    
    /**
     The tableview asks, "How many rows are in [section one]?" and we
        answer with this function; there is simply one section.
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bucketList.count
    }
}
