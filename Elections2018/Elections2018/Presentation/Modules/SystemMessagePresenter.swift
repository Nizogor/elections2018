//
//  SystemMessagePresenter.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 31/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation

protocol SystemMessagePresenter: class {
    func showSystemMessage(_ title: String?, message: String?, completion: (() -> Void)?)
}
