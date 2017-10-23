//
//  Page+CoreDataProperties.swift
//  Gaffiot
//
//  Created by Benoît Frisch on 23/10/2017.
//  Copyright © 2017 Benoît Frisch. All rights reserved.
//
//

import Foundation
import CoreData


extension Page {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Page> {
        return NSFetchRequest<Page>(entityName: "Page")
    }

    @NSManaged public var fileName: String?
    @NSManaged public var word: String?
    @NSManaged public var favorite: Bool

}
