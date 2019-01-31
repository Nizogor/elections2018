//
//  MainDependencyContainerType.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation

protocol MainDependencyContainerType: class {
    
    var saveService: SaveServiceType { get }
    
    // MARK: - Counter
    func makeCounterViewController(with coordinator: CounterCoordinationDelegate) -> CounterViewController
    
    // MARK: - Visitors
    func makeVisitorsViewController(with coordinator: BackButtonDelegate) -> VisitorsViewController
    
    // MARK: - Frauds
    func makeFraudsViewController(with coordinator: BackButtonDelegate) -> FraudsViewController
    
    // MARK: - Register fraud
    func makeRegisterFraudViewController(with coordinator: RegisterFraudCoordinationDelegate) -> RegisterFraudViewController
}
