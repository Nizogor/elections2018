//
//  MainDependencyContainer.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation

class MainDependencyContainer: MainDependencyContainerType {
    
    let saveService: SaveServiceType = SaveService()
    
    // MARK: - Counter
    
    func makeCounterViewController(with coordinator: CounterCoordinationDelegate) -> CounterViewController {
        let viewController = CounterViewController.instantiateViewController()
        viewController.viewModel = makeCounterViewModel(coordinator: coordinator)
        return viewController
    }
    
    private func makeCounterViewModel(coordinator: CounterCoordinationDelegate) -> CounterViewModelType {
        return CounterViewModel(saveService: saveService, coordinator: coordinator)
    }
    
    // MARK: - Visitors
    
    func makeVisitorsViewController(with coordinator: BackButtonDelegate) -> VisitorsViewController {
        let viewController = VisitorsViewController.instantiateViewController()
        viewController.viewModel = makeVisitorsViewModel(with: coordinator)
        return viewController
    }
    
    private func makeVisitorsViewModel(with coordinator: BackButtonDelegate) -> VisitorsViewModelType {
        return VisitorsViewModel(saveService: saveService, coordinator: coordinator)
    }
    
    // MARK: - Frauds
    
    func makeFraudsViewController(with coordinator: BackButtonDelegate) -> FraudsViewController {
        let viewController = FraudsViewController.instantiateViewController()
        viewController.viewModel = makeFraudsViewModel(with: coordinator)
        return viewController
    }
    
    private func makeFraudsViewModel(with coordinator: BackButtonDelegate) -> FraudsViewModelType {
        return FraudsViewModel(saveService: saveService, coordinator: coordinator)
    }
    
    // MARK: - Register fraud
    
    func makeRegisterFraudViewController(with coordinator: RegisterFraudCoordinationDelegate) -> RegisterFraudViewController {
        let viewController = RegisterFraudViewController.instantiateViewController()
        viewController.viewModel = makeRegisterFraudViewModel(with: coordinator)
        return viewController
    }
    
    private func makeRegisterFraudViewModel(with coordinator: RegisterFraudCoordinationDelegate) -> RegisterFraudViewModelType {
        return RegisterFraudViewModel(saveService: saveService, coordinator: coordinator)
    }
}
