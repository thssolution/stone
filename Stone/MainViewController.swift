//
//  FirstViewController.swift
//  Stone
//
//  Created by Denis Nascimento on 7/20/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController,CardIOPaymentViewControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var textCardNumber: UITextField!
    @IBOutlet weak var textCardName: UITextField!
    @IBOutlet weak var textCardmonth: UITextField!
    @IBOutlet weak var textCardYear: UITextField!
    @IBOutlet weak var textCardCVV: UITextField!
    @IBOutlet weak var textPrice: UITextField!
    @IBOutlet weak var boxFields: UIView!
    @IBOutlet weak var btnScan: UIButton!
    @IBOutlet weak var imageFlag: UIImageView!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.resetFields))
        self.view.addGestureRecognizer(tapGesture)
        
        
        self.setBottomBorder()
        
        if !CardIOUtilities.canReadCardWithCamera() {
            self.btnScan.hidden = true
        }else{
            CardIOUtilities.preload()
        }
    }
    
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -40
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func scanCard(sender: AnyObject) {
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC.modalPresentationStyle = .FormSheet
        presentViewController(cardIOVC, animated: true, completion: nil)
    }
    
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        
        if let info = cardInfo {
            self.textCardName.text = info.cardholderName
            self.textCardNumber.text = info.cardNumber
            self.textCardmonth.text = "\(info.expiryMonth)"
            self.textCardYear.text = "\(info.expiryYear)"
            self.textCardCVV.text = info.cvv
            self.imageFlag.image = info.cardImage
        }
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        addToolBar(textField)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

        let textFieldText: NSString = textField.text ?? ""
        let txtAfterUpdate = textFieldText.stringByReplacingCharactersInRange(range, withString: string)
        if let flag:UIImage = CreditCard.Flag(txtAfterUpdate) {
            self.imageFlag.image = flag
        }

        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        resetFields()
        return true
    }
    
    func resetFields() -> Void {
        
        for view  in self.boxFields.subviews
        {
            if let textField = view as? UITextField {
                textField.resignFirstResponder()
            }
        }
    }
    
    func setBottomBorder() -> Void {
        
        for view  in self.boxFields.subviews
        {
            if let textField = view as? UITextField {
                let bottomLine1 = CALayer()
                bottomLine1.backgroundColor = UIColor(red: 0.835, green: 0.835, blue: 0.835, alpha: 1.00).CGColor
                bottomLine1.frame = CGRectMake(0.0, textField.frame.height - 1, textField.frame.width, 1.0)
                bottomLine1.backgroundColor = UIColor.blackColor().CGColor
                textField.borderStyle = UITextBorderStyle.None
                textField.layer.addSublayer(bottomLine1)
                textField.layer.masksToBounds = true
            }
        }
    }
    
    @IBAction func goToSave(sender: AnyObject) {
        
        if checkFiedls() {
            self.saveTransaction()
        }else{
            let alert = UIAlertController(title: "Stone", message: "Todos os campos são obrigatórios", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
            showViewController(alert, sender: self);
        }
    }
    
    func checkFiedls() -> Bool {
        
        for view  in self.boxFields.subviews
        {
            if let textField = view as? UITextField {
                if textField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == "" {
                    return false
                }
            }
        }
        return true
    }
    
    func saveTransaction() {
        
        
        
        
        
        
        if let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate  as? AppDelegate {
            if let managedContext: NSManagedObjectContext = appDelegate.managedObjectContext{
                if  let transaction:TransactionsModel = NSEntityDescription.insertNewObjectForEntityForName("Transactions", inManagedObjectContext:managedContext) as? TransactionsModel {
                   
                    transaction.name = self.textCardName.text
                    transaction.number = self.textCardNumber.text
                    transaction.month = Int(self.textCardmonth.text!)
                    transaction.year = Int(self.textCardYear.text!)
                    transaction.cvv = Int(self.textCardCVV.text!)
                    transaction.price = Int(self.textPrice.text!)
                    transaction.date = NSDate()
                    transaction.type = 1
                    
                    
                    Downloader.addTransaction(transaction, completion: { (jsonAdd, isSuccess) in
                        
                        if isSuccess {
                            print("Não foi dado nenhum tratamento ao retorno do post, por que o resultado é mock, sempre vem o mesmo resultado")
                            do {
                                try managedContext.save()
                                let alert = UIAlertController(title: "Stone", message: "Transação efetuada com sucesso", preferredStyle: UIAlertControllerStyle.Alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                                self.showViewController(alert, sender: self);

                                
                            } catch let error as NSError  {
                                print("Could not save \(error), \(error.userInfo)")
                            }
                        }

                    })
                }
                
            }
        }
        
    }

}


extension MainViewController {
    
    func addToolBar(textField: UITextField){
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor.blackColor()
        let doneButton = UIBarButtonItem(title: "Fechar", style: UIBarButtonItemStyle.Done, target: self, action: #selector(MainViewController.resetFields))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
   }

