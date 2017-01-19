//
//  TransactionTableViewCell.swift
//  WarplyReturns
//
//  Created by Marsel Tzatzo on 19/01/2017.
//  Copyright © 2017 Marsel Tzatzo. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    
    static let key = "TransactionTableViewCell"
    static let nib = UINib.init(nibName: key, bundle: Bundle.main)
    
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var transactionTypeLabel: UILabel!
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var ammountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
