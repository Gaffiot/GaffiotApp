//
//  RootTabBarViewController.swift
//  Gaffiot
//
//  Created by Benoît Frisch on 22/10/2017.
//  Copyright © 2017 Benoît Frisch. All rights reserved.
//

import UIKit
import CoreData

class RootTabBarViewController: UITabBarController {
    var managedObjectContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        let averageController = self.viewControllers![0] as! ListNavigationViewController
        averageController.managedObjectContext = managedObjectContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
