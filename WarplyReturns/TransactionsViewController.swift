//
//  ViewController.swift
//  WarplyReturns
//
//  Created by Marsel Tzatzo on 19/01/2017.
//  Copyright © 2017 Marsel Tzatzo. All rights reserved.
//

import UIKit

class TransactionsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, TimeFrameChangeDelegate, TransactionTypeChangedDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeaderView: UIView!
    
    private var pieChartHeaderView = PieChartHeaderView()
    
    private let model = TransactionsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavbarTitle()
        self.setupTableView();
        
        self.model.loadTransactions { [unowned self] error in
            if let errorMessage = error {
                print("\(errorMessage)")
                return
            }
            self.updateUI()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupNavbarTitle() {
        // todo move strings in plist file
        self.title = "Οι συναλλαγές μου"
    }
    
    func setupTableView() {
        self.tableView.register(TransactionTableViewCell.nib, forCellReuseIdentifier: TransactionTableViewCell.key)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.pieChartHeaderView.timeFrameChangedDelegate = self
        self.pieChartHeaderView.transactionTypeChangeDelegate = self
        self.pieChartHeaderView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 0, height: 300))
        self.tableView.tableHeaderView = self.pieChartHeaderView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.key) as! TransactionTableViewCell
        let transaction = self.model[indexPath.row]
        configureCellWithTransaction(cell: cell, transaction: transaction)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 146.0;
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false;
    }
    
    // MARK: Helper
    
    func configureCellWithTransaction(cell: TransactionTableViewCell, transaction: TransactionDTO) {
        cell.transactionDateLabel.text = "\(self.getDateDescription(transaction.nDate!))"
        cell.transactionTypeLabel.text = "\(transaction.typeName!): \(transaction.totalAmmount!)€"
        cell.storeLabel.text = "\(transaction.partnerName!)"
        cell.cardNumberLabel.text = "xxxx xxxx xxxx \(self.getCardDescription(transaction.cardNum!))"
        cell.dateLabel.text = "Ημ. Λήξης: \(self.getDateDescription(transaction.expDate))"
        cell.ammountLabel.text = "\(transaction.points!)€"
    }
    
    func getCardDescription(_ cardNum: String) -> String {
        let start = cardNum.index(cardNum.startIndex, offsetBy: 8)
        let end = cardNum.index(start, offsetBy: 4)
        return cardNum.substring(with: start..<end)
    }
    
    func getDateDescription(_ date: Date?) -> String {
        if let dateUnwrapped = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "DD.MM.yyyy"
            return dateFormatter.string(from: dateUnwrapped)
        }
        return "-"
    }
    
    // MARK: Time Frame Changed
    
    func monthSelected() {
        print("monthSelected")
        self.model.currentTimeFrame = .Month
        updateUI()
    }
    
    func biannualSelected() {
        print("biannualSelected")
        self.model.currentTimeFrame = .Biannual
        updateUI()
    }
    
    func yearSelected() {
        print("yearSelected")
        self.model.currentTimeFrame = .Year
        updateUI()
    }
    
    // MARK: Transaction Type Changed
    
    func purchacesTypeSelected() {
        self.model.currentViewType = .Purchaces
        updateUI()
    }
    
    func refundTypeSelected() {
        self.model.currentViewType = .Refunds
        updateUI()
    }
    
    func updateUI() {
        self.tableView.reloadData()
        self.pieChartHeaderView.outerPieChartValue = self.model.outerPieCharValues
    }
    
}

