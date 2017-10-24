//
//  ImportViewController.swift
//  Gaffiot
//
//  Created by Benoît Frisch on 24/10/2017.
//  Copyright © 2017 Benoît Frisch. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class ImportViewController: UIViewController {
    private var words: JSON! = nil
    var managedObjectContext: NSManagedObjectContext!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.importWords()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseCurrent() {
        let path = Bundle.main.path(forResource: "gaffiot", ofType: "json")
        do {
            let content = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            if let dataFromString = content.data(using: .utf8, allowLossyConversion: false) {
                self.words = JSON(data: dataFromString)
            }
        } catch {
        }
    }
    
    func importWords() {
        self.parseCurrent()
        
        let totalCount: Int = words.arrayValue.count
        var totalDone: Int = 0
        
        let perc1 = Float(1.0 / Float(totalCount))
        var percentage: Float = 0.0
        print(Float(perc1))
        
        DispatchQueue.global(qos: .background).async {
            
            DispatchQueue.main.async {
        
        for i in 0...self.words.arrayValue.count - 1 {
                let latinId: String = self.words[i]["latin_raw"].stringValue
                let latin: String = self.words[i]["latin"].stringValue
                let french: String = self.words[i]["french"].stringValue
                
                // Create Entity
                let entity = NSEntityDescription.entity(forEntityName: "Word", in: self.managedObjectContext)
            
            
                // Initialize Record
                let word = Word(entity: entity!, insertInto: self.managedObjectContext)
                
                // Populate Record
                word.latinId = latinId
                word.latin = latin
                word.french = french
                
                do {
                    // Save Record
                    try word.managedObjectContext?.save()
                } catch {
                    let saveError = error as NSError
                    print("\(saveError), \(saveError.userInfo)")
                }
      
                self.statusLabel.text = "\(self.words[i]["latin"].stringValue)\n\(String(format: "%.2f", percentage * 100))%"
            
            
                self.progressBar.setProgress(percentage, animated: true)
            
                print("total done\(totalDone) \(percentage)")
                percentage += perc1
                totalDone = totalDone + 1
                                    
                if (totalDone >= totalCount) {
                    self.performSegue(withIdentifier: "start", sender: self)
                }
        }
            }
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "start") {
            let classVc = segue.destination as! RootTabBarViewController
            classVc.managedObjectContext = self.managedObjectContext
        }
    }

}
