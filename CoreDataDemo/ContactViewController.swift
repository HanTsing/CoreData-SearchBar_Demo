//
//  ContactEditViewController.swift
//  CoreDataDemo
//
//  Created by hanqing on 3/22/15.
//  Copyright (c) 2015 hanqing. All rights reserved.
//

import UIKit
import CoreData

class ContactViewController: UIViewController {
    
    var contact: Contact!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if contact != nil {
            nameTextField.text = contact.name
            title = "Edit Contact"
        } else {
             title = "New Contact"    
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
       navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func save(sender: AnyObject) {
        if contact != nil {
            contact?.name = nameTextField.text
            managedObjectContext?.save(nil)
        } else {
            contact = NSEntityDescription.insertNewObjectForEntityForName("Contact",
                inManagedObjectContext: managedObjectContext!) as Contact
            contact.name = nameTextField.text
            managedObjectContext?.save(nil)
        }

        navigationController?.popViewControllerAnimated(true)
    }


}
