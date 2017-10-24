//
//  AppDelegate.swift
//  Gaffiot
//
//  Created by Benoît Frisch on 22/10/2017.
//  Copyright © 2017 Benoît Frisch. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var words: JSON! = nil
    var persistentContainer: NSPersistentContainer!
    var managedObjectContext: NSManagedObjectContext!
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Override point for customization after application launch.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count - 1] as URL)
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.11, green:0.57, blue:0.96, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor(red:0.11, green:0.57, blue:0.96, alpha:1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        
        createGaffiotContainer(){ container in
            self.persistentContainer = container
            self.managedObjectContext = container.viewContext
            
            let storyboard = self.window?.rootViewController?.storyboard
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "RootTab") as? RootTabBarViewController
                else {
                    fatalError("Cannot instantiate root view controller")
            }
            vc.managedObjectContext = container.viewContext
            self.window?.rootViewController = vc
            
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
    }
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.TimerReminder" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count - 1] as NSURL
    }()
}

