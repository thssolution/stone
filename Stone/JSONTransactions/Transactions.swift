//
//  Transactions.swift
//
//  Created by Denis Nascimento on 7/21/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Transactions: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kTransactionsPriceKey: String = "price"
	internal let kTransactionsFlagKey: String = "flag"
	internal let kTransactionsNumberKey: String = "number"
	internal let kTransactionsYearKey: String = "year"
	internal let kTransactionsMonthKey: String = "month"
	internal let kTransactionsDateKey: String = "date"
	internal let kTransactionsCvvKey: String = "cvv"
	internal let kTransactionsNameKey: String = "name"


    // MARK: Properties
	public var price: String?
	public var flag: String?
	public var number: String?
	public var year: String?
	public var month: String?
	public var date: String?
	public var cvv: String?
	public var name: String?


    // MARK: SwiftyJSON Initalizers
    /**
    Initates the class based on the object
    - parameter object: The object of either Dictionary or Array kind that was passed.
    - returns: An initalized instance of the class.
    */
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }

    /**
    Initates the class based on the JSON that was passed.
    - parameter json: JSON object from SwiftyJSON.
    - returns: An initalized instance of the class.
    */
    public init(json: JSON) {
		price = json[kTransactionsPriceKey].string
		flag = json[kTransactionsFlagKey].string
		number = json[kTransactionsNumberKey].string
		year = json[kTransactionsYearKey].string
		month = json[kTransactionsMonthKey].string
		date = json[kTransactionsDateKey].string
		cvv = json[kTransactionsCvvKey].string
		name = json[kTransactionsNameKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if price != nil {
			dictionary.updateValue(price!, forKey: kTransactionsPriceKey)
		}
		if flag != nil {
			dictionary.updateValue(flag!, forKey: kTransactionsFlagKey)
		}
		if number != nil {
			dictionary.updateValue(number!, forKey: kTransactionsNumberKey)
		}
		if year != nil {
			dictionary.updateValue(year!, forKey: kTransactionsYearKey)
		}
		if month != nil {
			dictionary.updateValue(month!, forKey: kTransactionsMonthKey)
		}
		if date != nil {
			dictionary.updateValue(date!, forKey: kTransactionsDateKey)
		}
		if cvv != nil {
			dictionary.updateValue(cvv!, forKey: kTransactionsCvvKey)
		}
		if name != nil {
			dictionary.updateValue(name!, forKey: kTransactionsNameKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.price = aDecoder.decodeObjectForKey(kTransactionsPriceKey) as? String
		self.flag = aDecoder.decodeObjectForKey(kTransactionsFlagKey) as? String
		self.number = aDecoder.decodeObjectForKey(kTransactionsNumberKey) as? String
		self.year = aDecoder.decodeObjectForKey(kTransactionsYearKey) as? String
		self.month = aDecoder.decodeObjectForKey(kTransactionsMonthKey) as? String
		self.date = aDecoder.decodeObjectForKey(kTransactionsDateKey) as? String
		self.cvv = aDecoder.decodeObjectForKey(kTransactionsCvvKey) as? String
		self.name = aDecoder.decodeObjectForKey(kTransactionsNameKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(price, forKey: kTransactionsPriceKey)
		aCoder.encodeObject(flag, forKey: kTransactionsFlagKey)
		aCoder.encodeObject(number, forKey: kTransactionsNumberKey)
		aCoder.encodeObject(year, forKey: kTransactionsYearKey)
		aCoder.encodeObject(month, forKey: kTransactionsMonthKey)
		aCoder.encodeObject(date, forKey: kTransactionsDateKey)
		aCoder.encodeObject(cvv, forKey: kTransactionsCvvKey)
		aCoder.encodeObject(name, forKey: kTransactionsNameKey)

    }

}
