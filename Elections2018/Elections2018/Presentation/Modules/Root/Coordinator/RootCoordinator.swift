//
//  RootCoordinator.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import UIKit

class RootCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let window: UIWindow
    let dependencyContainer: RootDependencyContainerType
    
    // MARK: - Initialization
    
    init(window: UIWindow, dependencyContainer: RootDependencyContainerType) {
        self.window = window
        self.dependencyContainer = dependencyContainer
    }
    
    // MARK: - Methods
    
    override func start() {
        
        let presenter = UINavigationController()
        presenter.navigationBar.isHidden = true
        self.presenter = presenter
        
        window.rootViewController = presenter
        window.makeKeyAndVisible()
        
        let viewController = dependencyContainer.makeRootViewController(with: self)
        presenter.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
        fatalError("You're trying to finish root coordinator!")
    }
}

// MARK: - RootCoordinationDelegate

extension RootCoordinator: RootCoordinationDelegate {
    func rootViewDidAppear() {
        let mainCoordinator = dependencyContainer.makeMainCoordinator()
        addChildCoordinator(mainCoordinator)
    }
}
