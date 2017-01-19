//
//  TransactionDTO.swift
//  WarplyReturns
//
//  Created by Marsel Tzatzo on 19/01/2017.
//  Copyright © 2017 Marsel Tzatzo. All rights reserved.
//

import UIKit
import ObjectMapper

class TransactionDTO: Mappable {
    
    var totalAmmount: Double?
    var typeName: String?
    var points: Double?
    var partnerName: String?
    var cardNum: String?
    var expDate: Date?
    var nDate: Date?
    var remainingPoints: Double?
    
    let transform = TransformOf<Date, String>(fromJSON: { (jsonDate) -> Date? in
        if let date = jsonDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-DD'T'HH:mm:ssZZZ"
            return dateFormatter.date(from: date)
        }
        return nil
    }) { (dateObj) -> String? in
        return nil
    }
    
    //MARK: Mappable
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        totalAmmount        <- map["custfintrxntotalamt"]
        typeName            <- map["custfintrxntypename"]
        points              <- map["custacccardpoints"]
        partnerName         <- map["partnername"]
        cardNum             <- map["custacccardnum"]
        expDate             <- (map["custacccardpointexpdate"], transform)
        nDate               <- (map["custfintrxndate"], transform)
        remainingPoints     <- map["custacccardremainingpoints"]
    }
    
    
}
