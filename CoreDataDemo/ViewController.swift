//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by hanqing on 3/22/15.
//  Copyright (c) 2015 hanqing. All rights reserved.
//

import UIKit

import CoreData

class ViewController: UIViewController {
    
    var contacts = []

    override func viewDidLoad() {
        super.viewDidLoad()
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as
            AppDelegate).managedObjectContext {
            let fetchRequest = NSFetchRequest(entityName: "Contact")
            var e: NSError?
            contacts = managedObjectContext.executeFetchRequest(fetchRequest, error: &e) as
                [Contact]
        }
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

