//
//  JSONTransactions.swift
//
//  Created by Denis Nascimento on 7/21/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class JSONTransactions: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kJSONTransactionsCodeKey: String = "code"
	internal let kJSONTransactionsTransactionsKey: String = "transactions"


    // MARK: Properties
	public var code: String?
	public var transactions: [Transactions]?


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
		code = json[kJSONTransactionsCodeKey].string
		transactions = []
		if let items = json[kJSONTransactionsTransactionsKey].array {
			for item in items {
				transactions?.append(Transactions(json: item))
			}
		} else {
			transactions = nil
		}

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if code != nil {
			dictionary.updateValue(code!, forKey: kJSONTransactionsCodeKey)
		}
		if transactions?.count > 0 {
			var temp: [AnyObject] = []
			for item in transactions! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kJSONTransactionsTransactionsKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.code = aDecoder.decodeObjectForKey(kJSONTransactionsCodeKey) as? String
		self.transactions = aDecoder.decodeObjectForKey(kJSONTransactionsTransactionsKey) as? [Transactions]

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(code, forKey: kJSONTransactionsCodeKey)
		aCoder.encodeObject(transactions, forKey: kJSONTransactionsTransactionsKey)

    }

}
