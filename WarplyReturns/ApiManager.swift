//
//  ApiManager.swift
//  WarplyReturns
//
//  Created by Marsel Tzatzo on 19/01/2017.
//  Copyright © 2017 Marsel Tzatzo. All rights reserved.
//

import UIKit
import Alamofire

class ApiManager {

    static let shared = ApiManager()
    
    private init() { }
    
    public func fetchTransactions(completion: @escaping ([TransactionDTO]?, Error?) -> ()) {
        Alamofire.request(Constants.Api.url).responseString{ response in
            switch response.result {
            case .success(let value):
                let transactionsResponse = TransactionsResponse(JSONString: value)
                if ((transactionsResponse?.error) != nil) {
                    // toto custom domain error
                    return
                }
                completion(transactionsResponse?.response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
