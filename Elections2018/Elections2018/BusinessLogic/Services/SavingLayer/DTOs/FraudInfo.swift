//
//  FraudInfo.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 31/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation

struct FraudInfo {
    
    let identifier: String
    let date: Date
    let comment: String
    
    init(identifier: String, date: Date, comment: String) {
        self.identifier = identifier
        self.date = date
        self.comment = comment
    }
    
    init(fraud: Fraud) throws {
        guard let identifier = fraud.identifier,
            let date = fraud.date,
            let comment = fraud.comment else {
                throw SaveServiceError.wrongEntity
        }
        self.identifier = identifier
        self.date = date
        self.comment = comment
    }
}
