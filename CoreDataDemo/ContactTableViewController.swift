//
//  ContactTableViewController.swift
//  CoreDataDemo
//
//  Created by hanqing on 3/22/15.
//  Copyright (c) 2015 hanqing. All rights reserved.
//

import UIKit

import CoreData

class ContactTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var searchController: UISearchController!
    var searchResults:[Contact] = []
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = UIColor.blackColor()
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest = NSFetchRequest(entityName: "Contact")
        var e: NSError?
        contacts = managedObjectContext?.executeFetchRequest(fetchRequest, error: &e) as
            [Contact]
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                let cellIdentifier = "Cell"
                let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath:
                indexPath) as ContactTableViewCell

                let contact = (searchController.active) ? searchResults[indexPath.row] : contacts[indexPath.row]
                cell.nameTextField.text = contact.name
                return cell
      
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active {
            return searchResults.count
        } else {
            return contacts.count
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            managedObjectContext?.deleteObject(contacts[indexPath.row] as NSManagedObject)
            contacts.removeAtIndex(indexPath.row)
            managedObjectContext?.save(nil)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "update" {
            if let row = tableView.indexPathForSelectedRow()?.row {
                let destinationController = segue.destinationViewController as ContactViewController
                destinationController.contact  = contacts[row]
            }
        } else if segue.identifier == "add"  {
            if let row = tableView.indexPathForSelectedRow()?.row {
                let destinationController = segue.destinationViewController as ContactViewController
            }
        }
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active {
            return false
        } else {
            return true
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }
    
    func filterContentForSearchText(searchText: String) {
        searchResults = contacts.filter({ ( contact: Contact) -> Bool in
            
            let nameMatch = contact.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return nameMatch != nil
            
        })
        
    }
    
    
    
}
