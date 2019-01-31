//
//  StoryboardInstantiable.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import UIKit

// Coordinator Pattern with Storyboards https://www.raywenderlich.com/158-coordinator-tutorial-for-ios-getting-started

protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype MyType
    static func instantiateViewController(_ bundle: Bundle?) -> MyType
}

extension StoryboardInstantiable where Self: UIViewController {
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = String(aClass: Self.self)
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        return storyboard.instantiateInitialViewController() as! Self
    }
}
