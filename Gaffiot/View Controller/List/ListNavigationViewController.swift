//
//  ListNavigationViewController.swift
//  Gaffiot
//
//  Created by Benoît Frisch on 23/10/2017.
//  Copyright © 2017 Benoît Frisch. All rights reserved.
//

import UIKit
import CoreData

class ListNavigationViewController: UINavigationController {
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = self.viewControllers[0] as! ListTableViewController
        controller.managedObjectContext = managedObjectContext
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



