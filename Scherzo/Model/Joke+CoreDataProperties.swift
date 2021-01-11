//
//  Joke+CoreDataProperties.swift
//  Scherzo
//
//  Created by Mike Shevelinsky on 11.01.2021.
//
//

import Foundation
import CoreData


extension Joke {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Joke> {
        return NSFetchRequest<Joke>(entityName: "Joke")
    }

    @NSManaged public var id: Int64
    @NSManaged public var punchline: String?
    @NSManaged public var setup: String?
    @NSManaged public var title: String?

}

extension Joke : Identifiable {

}
