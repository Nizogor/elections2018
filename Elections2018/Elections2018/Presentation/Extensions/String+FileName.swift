//
//  String+FileName.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 31/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation

extension String {
    // File name from class
    init(aClass: AnyClass) {
        self = NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}
