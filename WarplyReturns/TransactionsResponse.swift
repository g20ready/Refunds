//
//  TransactionsResponse.swift
//  WarplyReturns
//
//  Created by Marsel Tzatzo on 19/01/2017.
//  Copyright © 2017 Marsel Tzatzo. All rights reserved.
//

import UIKit
import ObjectMapper

class TransactionsResponse: Mappable {
    
    var status: Int?
    var error: String?
    var response: [TransactionDTO]?
    
    //MARK: Mappable
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status      <- map["status"]
        error       <- map["error"]
        response    <- map["response"]
    }
    
    
}
