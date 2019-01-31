//
//  Visitor.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation
import RealmSwift

class Visitor: Object {
    
    @objc dynamic var identifier: String? = nil
    @objc dynamic var date: Date? = nil
    
    convenience init(info: VisitorInfo) {
        self.init()
        identifier = info.identifier
        date = info.date
    }
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
}
