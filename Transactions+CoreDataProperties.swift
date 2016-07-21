//
//  Transactions+CoreDataProperties.swift
//  Stone
//
//  Created by Denis Nascimento on 7/21/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TransactionsModel {

    @NSManaged var name: String?
    @NSManaged var number: String?
    @NSManaged var month: NSNumber?
    @NSManaged var year: NSNumber?
    @NSManaged var cvv: NSNumber?
    @NSManaged var type: NSNumber?
    @NSManaged var date: NSDate?
    @NSManaged var price: NSNumber?

}
