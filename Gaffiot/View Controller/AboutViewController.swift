//
//  AboutViewController.swift
//  Gaffiot
//
//  Created by Benoît Frisch on 24/10/2017.
//  Copyright © 2017 Benoît Frisch. All rights reserved.
//


import UIKit
import Firebase

class AboutViewController: UITableViewController {
    @IBOutlet var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionLabel.text = "Version \(Bundle.main.releaseVersionNumber!) (\(Bundle.main.buildVersionNumber!))"
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "About" as NSObject,
            AnalyticsParameterItemName: "About" as NSObject,
            AnalyticsParameterContentType: "about" as NSObject
            ])
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openGithub(_ sender: Any) {
        // Create the alert controller
        let alertController = UIAlertController(title: "GitHub", message: "", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Open", style: UIAlertActionStyle.default) {
            UIAlertAction in
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string:"https://github.com/Gaffiot/GaffiotApp")!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string:
                    "https://github.com/Gaffiot/GaffiotApp")!)
            }
        }
        let cancelAction = UIAlertAction(title: "Annuler", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
