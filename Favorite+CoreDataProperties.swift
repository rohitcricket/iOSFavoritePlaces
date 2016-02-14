//
//  Favorite+CoreDataProperties.swift
//  My Favorite Places
//
//  Created by ROHIT GUPTA on 2/12/16.
//  Copyright © 2016 ROHIT GUPTA. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Favorite {

    @NSManaged var name: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var latitudeDelta: NSNumber?
    @NSManaged var longitudeDelta: NSNumber?

}
