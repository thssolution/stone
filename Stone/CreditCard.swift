//
//  CreditCard.swift
//  Stone
//
//  Created by Denis Nascimento on 7/20/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

import UIKit

class CreditCard: AnyObject {
    
    
   class func name(cardNumber: String) -> String {

            
            let regVisa = "^4[0-9]{12}(?:[0-9]{3})?$"
            let regMaster = "^5[1-5][0-9]{14}$"
            let regExpress = "^3[47][0-9]{13}$"
            let regDiners = "^3(?:0[0-5]|[68][0-9])[0-9]{11}$"
            let regDiscover = "^6(?:011|5[0-9]{2})[0-9]{12}$"
        
            let regVisaTest = NSPredicate(format: "SELF MATCHES %@", regVisa)
            let regMasterTest = NSPredicate(format: "SELF MATCHES %@", regMaster)
            let regExpressTest = NSPredicate(format: "SELF MATCHES %@", regExpress)
            let regDinersTest = NSPredicate(format: "SELF MATCHES %@", regDiners)
            let regDiscoverTest = NSPredicate(format: "SELF MATCHES %@", regDiscover)
        
            
            
            if regVisaTest.evaluateWithObject(cardNumber){
                return "Visa"
            }
            else if regMasterTest.evaluateWithObject(cardNumber){
                return "MasterCard"
            }
                
            else if regExpressTest.evaluateWithObject(cardNumber){
                return "American Express"
            }
                
            else if regDinersTest.evaluateWithObject(cardNumber){
                return "Diners Club"
            }
                
            else if regDiscoverTest.evaluateWithObject(cardNumber){
                return "Discover"
            }
            return ""
            
        }
    
    
    class func Flag(cardNumber: String) -> UIImage! {
        
        
        let regVisa = "^4[0-9]{12}(?:[0-9]{3})?$"
        let regMaster = "^5[1-5][0-9]{14}$"
        let regExpress = "^3[47][0-9]{13}$"
        let regDiners = "^3(?:0[0-5]|[68][0-9])[0-9]{11}$"
        let regDiscover = "^6(?:011|5[0-9]{2})[0-9]{12}$"
        
        let regVisaTest = NSPredicate(format: "SELF MATCHES %@", regVisa)
        let regMasterTest = NSPredicate(format: "SELF MATCHES %@", regMaster)
        let regExpressTest = NSPredicate(format: "SELF MATCHES %@", regExpress)
        let regDinersTest = NSPredicate(format: "SELF MATCHES %@", regDiners)
        let regDiscoverTest = NSPredicate(format: "SELF MATCHES %@", regDiscover)
        
        
        
        if regVisaTest.evaluateWithObject(cardNumber){
            return UIImage(named: "visa")!
        }
        else if regMasterTest.evaluateWithObject(cardNumber){
            return UIImage(named: "master")!
        }
            
        else if regExpressTest.evaluateWithObject(cardNumber){
            return UIImage(named: "amex")!
        }
            
        else if regDinersTest.evaluateWithObject(cardNumber){
            return UIImage(named: "dinnes")!
        }
            
        else if regDiscoverTest.evaluateWithObject(cardNumber){
            return UIImage(named: "dinnes")!
        }
        return nil
        
    }
    

}
