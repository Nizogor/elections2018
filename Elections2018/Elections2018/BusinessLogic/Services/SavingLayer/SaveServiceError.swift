//
//  SaveServiceError.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 31/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation

enum SaveServiceError: Error {
    case wrongEntity
    case nonexistantEntity
}

extension SaveServiceError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .wrongEntity:
            return "An entity has wrong parameter"
        case .nonexistantEntity:
            return "Trying to delete nonexistant entity"
        }
    }
}
