//
//  CounterCoordinationDelegate.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation

protocol CounterCoordinationDelegate: SystemMessagePresenter {
    func visitsTap()
    func fraudsTap()
    func registerFraudTap()
}
