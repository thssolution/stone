//
//  Transactions.swift
//  Stone
//
//  Created by Denis Nascimento on 7/21/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

import Foundation
import CoreData

@objc(TransactionsModel)
class TransactionsModel: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

}


extension NSDateFormatter {
    convenience init(dateStyle: NSDateFormatterStyle) {
        self.init()
        self.dateStyle = dateStyle
    }
}

extension NSDate {
    struct Formatter {
        static let shortDate = NSDateFormatter(dateStyle: .ShortStyle)
        static let longStyle = NSDateFormatter(dateStyle: .LongStyle)
    }
    var shortDate: String {
        return Formatter.shortDate.stringFromDate(self)
    }
    
    var longStyle: String {
        return Formatter.longStyle.stringFromDate(self)
    }
}