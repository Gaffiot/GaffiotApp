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
    container.loadPersistentStores { _, error in
        guard error == nil else { fatalError("Failed to load store: \(String(describing: error))") }
        DispatchQueue.main.async { completion(container) }
    }
}


