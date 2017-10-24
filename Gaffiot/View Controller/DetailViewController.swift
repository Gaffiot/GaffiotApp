//
//  DetailViewController.swift
//  Gaffiot
//
//  Created by Benoît Frisch on 24/10/2017.
//  Copyright © 2017 Benoît Frisch. All rights reserved.
//

import UIKit
import Regex

class DetailViewController: UIViewController {
    var word : Word!
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = word.latin
        var content : String! = word.french
        
        //replacing all tags in content\raise-0.3ex\hbox{\arabe
        
        content = content.replacingAll(matching: "\\\\begintriplecolumns", with: "")
        content = content.replacingAll(matching: "\\\\endtriplecolumns", with: "")
        content = content.replacingAll(matching: "\\\\vfill", with: "")
        content = content.replacingAll(matching: "\\\\eject", with: "")
        content = content.replacingAll(matching: "\\\\kkz\\{([^\\}]+)\\}", with: "")
        content = content.replacingAll(matching: "\\\\raise-0.3ex\\\\hbox\\{\\\\arabe([^\\}]+)\\}", with: "$1")
        content = content.replacingAll(matching: "\\\\aut\\{([^\\}]+)\\}", with: "<aut>$1</aut>")
        content = content.replacingAll(matching: "\\\\autp\\{([^\\}]+)\\}", with: "<aut>$1</aut>")
        content = content.replacingAll(matching: "\\\\cl\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\comm\\{([^\\}]+)\\}", with: "")
        content = content.replacingAll(matching: "\\\\el\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\es\\{([^\\}]+)\\}", with: "<b>$1</b>")
        content = content.replacingAll(matching: "\\\\etymgr\\{([^\\}]+)\\}", with: "$1")
        content = content.replacingAll(matching: "\\\\etyml\\{([^\\}]+)\\}", with: "$1")
        content = content.replacingAll(matching: "\\\\F", with: "&#8611;")
        content = content.replacingAll(matching: "\\\\freq\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\gen\\{([^\\}]+)\\}", with: "$1")
        content = content.replacingAll(matching: "\\\\gras\\{([^\\}]+)\\}", with: "<strong>$1</strong>")
        content = content.replacingAll(matching: "\\\\grec\\{([^\\}]+)\\}", with: "$1")
        content = content.replacingAll(matching: "\\\\ital\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\italp\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\lat\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\latc\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\latdim\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\latgen\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\latp\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\latpf\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\latpl\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\latv\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\oeuv\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\par", with: "<br><br>")
        content = content.replacingAll(matching: "\\\\pc\\{([^\\}]+)\\}", with: "<aut>$1</aut>")
        content = content.replacingAll(matching: "\\\\pca\\{([^\\}]+)\\}", with: "<aut>$1</aut>")
        content = content.replacingAll(matching: "\\\\pp\\{([^\\}]+)\\}", with: "<br><pp>&para; $1</pp>")
        content = content.replacingAll(matching: "\\\\qq\\{([^\\}]+)\\}", with: "<br><qq>$1</qq>")
        content = content.replacingAll(matching: "\\\\qqng\\{([^\\}]+)\\}", with: "<br><qqng>$1</qqng>")
        content = content.replacingAll(matching: "\\\\refch\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\refchp\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\refgaf\\{([^\\}]+)\\}", with: "<i>$1</i>")
        content = content.replacingAll(matching: "\\\\romain\\{([^\\}]+)\\}", with: "$1")
        content = content.replacingAll(matching: "\\\\rub\\{([^\\}]+)\\}", with: "<rub>$1</rub>")
        content = content.replacingAll(matching: "\\\\S", with: "&sect;")
        content = content.replacingAll(matching: "\\\\up\\{([^\\}]+)\\}", with: "<sup>$1</sup>")
        content = content.replacingAll(matching: "||", with: "|| <br>")
        
        webView.loadHTMLString("<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\"><style>b {font-size:22px} rub{font-size:22px; font-weight:bold; color:#1C92F6} aut{text-transform: uppercase;} pp{font-size:20px; font-weight:bold; color: red} qq{font-size:18px; font-weight:bold; margin-left: 16px; color: #bb4331} qq{font-size:18px; margin-left: 16px; color: #bb4331}</style></head><body><b>\(word.latin!)</b>\(content!)</body></html>", baseURL: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
