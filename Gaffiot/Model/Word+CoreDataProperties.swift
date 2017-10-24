//
//  Word+CoreDataProperties.swift
//  Gaffiot
//
//  Created by Benoît Frisch on 24/10/2017.
//  Copyright © 2017 Benoît Frisch. All rights reserved.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var favorite: Bool
    @NSManaged public var french: String?
    @NSManaged public var latin: String?
    @NSManaged public var latinId: String?
    @NSManaged public var wordId: Int64

}
