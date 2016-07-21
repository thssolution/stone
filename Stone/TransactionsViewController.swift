//
//  SecondViewController.swift
//  Stone
//
//  Created by Denis Nascimento on 7/20/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

import UIKit
import CoreData

class TransactionsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var items = [TransactionsModel]()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updateContent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "TransactionCell", bundle:nil), forCellReuseIdentifier: "transactionCell")        
        self.tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateContent() -> Void {
        
        if let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate  as? AppDelegate {
            if let managedContext: NSManagedObjectContext = appDelegate.managedObjectContext {
                if  let employeesFetch:NSFetchRequest = NSFetchRequest(entityName: "Transactions") {
                    do {
                        self.items = try managedContext.executeFetchRequest(employeesFetch) as! [TransactionsModel]
                        self.tableView.reloadData()
                    } catch {
                        fatalError("Failed to fetch employees: \(error)")
                    }
                }
            }
        }
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("transactionCell", forIndexPath: indexPath) as! TransactionCell
        cell.setContent(items[indexPath.row])
        return cell
        
    }
    

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
}

