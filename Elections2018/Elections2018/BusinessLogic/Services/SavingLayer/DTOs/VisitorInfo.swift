//
//  VisitorInfo.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 31/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation

struct VisitorInfo {
    
    let identifier: String
    let date: Date
    
    init(identifier: String, date: Date) {
        self.identifier = identifier
        self.date = date
    }
    
    init(visitor: Visitor) throws {
        guard let identifier = visitor.identifier, let date = visitor.date else {
            throw SaveServiceError.wrongEntity
        }
        self.identifier = identifier
        self.date = date
    }
}
