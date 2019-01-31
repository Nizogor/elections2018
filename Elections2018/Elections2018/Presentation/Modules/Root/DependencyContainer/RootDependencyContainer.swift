//
//  RootDependencyContainer.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation

class RootDependencyContainer: RootDependencyContainerType {
    
    // MARK: Root
    
    func makeRootViewController(with coordinator: RootCoordinationDelegate) -> RootViewController {
        let viewModel = makeRootViewModel(with: coordinator)
        let viewController = RootViewController.instantiateViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func makeRootViewModel(with coordinator: RootCoordinationDelegate) -> RootViewModelType {
        return RootViewModel(coordinator: coordinator)
    }
    
    // MARK: Main
    
    func makeMainCoordinator() -> Coordinator {
        return MainCoordinator(dependencyContainer: makeMainDependencyContainer())
    }
    
    private func makeMainDependencyContainer() -> MainDependencyContainerType {
        return MainDependencyContainer()
    }
}
