//
//  MainCoordinator.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let dependencyContainer: MainDependencyContainerType
    
    // MARK: - Initialization
    
    init(dependencyContainer: MainDependencyContainerType) {
        self.dependencyContainer = dependencyContainer
    }
    
    // MARK: - Methods
    
    override func start() {
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        self.presenter = navigationController
        
        let viewController = dependencyContainer.makeCounterViewController(with: self)
        navigationController.pushViewController(viewController, animated: true)
        navigationController.modalTransitionStyle = .crossDissolve
        
        parentCoordinator?.presenter?.present(navigationController, animated: true)
    }
}

extension MainCoordinator: CounterCoordinationDelegate {
    
    func visitsTap() {
        let viewController = dependencyContainer.makeVisitorsViewController(with: self)
        presenter?.pushViewController(viewController, animated: true)
    }
    
    func fraudsTap() {
        let viewController = dependencyContainer.makeFraudsViewController(with: self)
        presenter?.pushViewController(viewController, animated: true)
    }
    
    func registerFraudTap() {
        let viewController = dependencyContainer.makeRegisterFraudViewController(with: self)
        presenter?.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: RegisterFraudCoordinationDelegate {
    
}
