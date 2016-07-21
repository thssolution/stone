//
//  Downloader.swift
//  MPlantonista
//
//  Created by Denis Nascimento on 5/10/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Downloader: AnyObject {

    class func addTransaction(transaction: TransactionsModel, completion: (jsonAdd: JSONTransactions!, isSuccess: Bool ) -> Void) {
   
       var parameters = [String : AnyObject]()
        parameters = [
            "name": transaction.name!,
            "number": transaction.number!,
            "month": transaction.month!,
            "year": transaction.year!,
            "cvv": transaction.cvv!,
            "price": transaction.price!,
            "date": transaction.date!
        ]
    
            Alamofire.request(.POST,"http://private-ad756-stoneapp.apiary-mock.com/transactions",parameters: parameters)
                .responseJSON { response in
                    
                    switch response.result {
                    case .Success:
                        let json = JSON(data: response.data! )
                        let obj :JSONTransactions = JSONTransactions(json: json)
                        completion(jsonAdd:obj,isSuccess: true)
                    case .Failure:
                        completion(jsonAdd: nil, isSuccess: false)
                    }
            }
   
    }
}
