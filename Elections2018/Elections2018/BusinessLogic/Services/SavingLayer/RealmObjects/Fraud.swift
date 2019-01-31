//
//  Fraud.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation
import RealmSwift

class Fraud: Object {
    
    @objc dynamic var identifier: String? = nil
    @objc dynamic var date: Date? = nil
    @objc dynamic var comment: String? = nil
    
    convenience init(info: FraudInfo) {
        self.init()
        identifier = info.identifier
        date = info.date
        comment = info.comment
    }
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
}
