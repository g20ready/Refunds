//
//  TransactionsModel.swift
//  WarplyReturns
//
//  Created by Marsel Tzatzo on 19/01/2017.
//  Copyright © 2017 Marsel Tzatzo. All rights reserved.
//

import UIKit

class TransactionsModel {

    public enum ViewType {
        case Purchaces
        case Refunds
    }
    
    var currentViewType = ViewType.Refunds {
        didSet {
            updateTransactionsForCurrentState()
            updatePieCharValues()
        }
    }
    
    public enum TimeFrame {
        case Month
        case Biannual
        case Year
    }
    
    var currentTimeFrame = TimeFrame.Month {
        didSet {
            updateTransactionsForCurrentState()
            updatePieCharValues()
        }
    }
    
    private var serverTransactions : [TransactionDTO]?
    
    private var transactions = [TransactionDTO]()
    
    subscript(index: Int) -> TransactionDTO {
        return self.transactions[index]
    }
    
    var count : Int {
        return self.transactions.count
    }
    
    var outerPieCharValues: [(Double, UIColor)] = [(0, UIColor.clear)]
    
    public init() { }
    
    public func loadTransactions(completion: @escaping (String?) -> ()) {
        ApiManager.shared.fetchTransactions { (transactions, error) in
            if let err = error {
                //todo show error to user, with retry button
                completion("An unexpected error occurred \(err)")
                return
            }
            self.serverTransactions = transactions
            print("fetched \(self.serverTransactions?.count) transactions")
            self.updateTransactionsForCurrentState()
            completion(nil)
        }
    }
    
    func updateTransactionsForCurrentState() {
        let transactionType = getTransactionTypeForCurrentState()
        let dateThreshold = getThresholdForCurrentState()
        if let _ = self.serverTransactions {
            self.transactions = (self.serverTransactions?.filter({ (transaction) -> Bool in
                if transaction.nDate == nil {
                    print(transaction)
                }
                return transaction.nDate!.isGreaterThanDate(dateThreshold)
                    && transaction.typeName == transactionType
            }))!
        }
    }
    
    func updatePieCharValues() {
        self.outerPieCharValues = [(
            self.transactions.reduce(0) { $0 + $1.totalAmmount!},
            getColorForCurrentState()
            )]
    }
    
    func getColorForCurrentState() -> UIColor {
        switch currentViewType {
        case .Purchaces:
            return Constants.Colors.orange
        case .Refunds:
            return Constants.Colors.purple
        }
    }
    
    func getThresholdForCurrentState() -> Date {
        var timeInterval = DateComponents()
        switch currentTimeFrame {
        case .Month:
            timeInterval.month = -1
            break
        case .Biannual:
            timeInterval.month = -6
            break
        case .Year:
            timeInterval.month = -12
        }
        let date = Calendar.current.date(byAdding: timeInterval, to: Date())!
        return date
    }
    
    func getTransactionTypeForCurrentState() -> String {
        switch currentViewType {
        case .Purchaces:
            return "Αγορά"
        case .Refunds:
            return "Εξαργύρωση"
        }
    }
    
}
