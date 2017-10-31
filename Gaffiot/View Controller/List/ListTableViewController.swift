//
//  ListTableViewController.swift
//  Gaffiot
//
//  Created by Benoît Frisch on 23/10/2017.
//  Copyright © 2017 Benoît Frisch. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData
import Firebase

class ListTableViewController: UITableViewController, UISearchBarDelegate {
    var managedObjectContext: NSManagedObjectContext!
    private var search = ""
    @IBOutlet var searchBar: UISearchBar!
    
    lazy var fetchedResultsController: NSFetchedResultsController<Word> = {
        // Initialize Fetch Request
        let fetchRequest: NSFetchRequest<Word> = Word.fetchRequest()
        
        // Add Sort Descriptors
        let latin = NSSortDescriptor(key: "wordId", ascending: true)
        fetchRequest.sortDescriptors = [latin]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "List" as NSObject,
            AnalyticsParameterItemName: "List" as NSObject,
            AnalyticsParameterContentType: "list" as NSObject
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "gaffiot")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("searchText \(String(describing: searchBar.text))")
        self.search(searchString: searchBar.text!)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(String(describing: searchBar.text))")
        self.search(searchString: searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(String(describing: searchBar.text))")
        self.search(searchString: "")
    }
    
    // called when text changes (including clear)
    internal func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        fetchedResultsController.fetchRequest.predicate = nil
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
        tableView.reloadData()
    }
    
    
    func search(searchString: String) {
        self.search = searchString
        var predicate:NSPredicate? = nil
        if searchString.count != 0 {
            predicate = NSPredicate(format: "(latinId BEGINSWITH [c] %@) OR (latinId BEGINSWITH [c] %@) OR (latinId BEGINSWITH [c] %@) OR (latinId BEGINSWITH [c] %@) OR (latinId BEGINSWITH [c] %@) OR (latinId BEGINSWITH [c] %@)", searchString, "1 "+searchString, "2 "+searchString, "3 "+searchString, "4 "+searchString, "5 "+searchString)
        }
        fetchedResultsController.fetchRequest.predicate = predicate
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
        
        let word = fetchedResultsController.object(at: IndexPath(row: indexPath.row, section: 0))
        
        cell.textLabel?.text = word.latin
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "show") {
            let classVc = segue.destination as! DetailViewController
            classVc.word = self.fetchedResultsController.object(at: tableView.indexPathForSelectedRow!) as Word
        }
    }

}
