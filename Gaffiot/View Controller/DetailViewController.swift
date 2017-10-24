//
//  DetailViewController.swift
//  Gaffiot
//
//  Created by Benoît Frisch on 24/10/2017.
//  Copyright © 2017 Benoît Frisch. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var word : Word!
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = word.latin
        webView.loadHTMLString("<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\"></head><body><h1>\(word.latin!)</h1><p>\(word.french!)</p></body></html>", baseURL: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
