//
//  TransactionCell.swift
//  Stone
//
//  Created by Denis Nascimento on 7/21/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var LabelPrice: UILabel!
    @IBOutlet weak var labelDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setContent(transaction:TransactionsModel) -> Void {
      
        if let name = transaction.name {
            self.labelName.text = name
        }
        if let number = transaction.number {
            self.labelNumber.text = "Card: \(number)"
        }
        if let price = transaction.price {
            self.LabelPrice.text = "Valor: R$ \(price)"
        }
        if let date:NSDate = transaction.date {
            self.labelDate.text = "Data: \(date.longStyle)"
        }
    }
}
