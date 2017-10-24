//
//  GaffiotStack.swift
//  Gaffiot
//
//  Created by Benoît Frisch on 22/10/2017.
//  Copyright © 2017 Benoît Frisch. All rights reserved.
//

import CoreData


func createGaffiotContainer(completion: @escaping (NSPersistentContainer) -> ()) {
    let container = NSPersistentContainer(name: "Gaffiot")
    let directory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0] as NSURL
    
    let url = directory.appendingPathComponent("Gaffiot.sqlite")
    
    if !FileManager.default.fileExists(atPath: url!.path) {
        let sourceSqliteURLs = [Bundle.main.url(forResource: "Gaffiot", withExtension: "sqlite"),
                                Bundle.main.url(forResource: "Gaffiot", withExtension: "sqlite-wal"),
                                Bundle.main.url(forResource: "Gaffiot", withExtension: "sqlite-shm")]
        
        let destSqliteURLs = [directory.appendingPathComponent("Gaffiot.sqlite"),
                              directory.appendingPathComponent("Gaffiot.sqlite-wal"),
                              directory.appendingPathComponent("Gaffiot.sqlite-shm")]
        
        for i in 0...sourceSqliteURLs.count-1 {
            do {
                try FileManager.default.copyItem(at: sourceSqliteURLs[i]!, to: destSqliteURLs[i]!)
            } catch {
            }
        }
    }
    container.loadPersistentStores { _, error in
        guard error == nil else { fatalError("Failed to load store: \(String(describing: error))") }
        DispatchQueue.main.async { completion(container) }
    }
}



