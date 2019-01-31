//
//  Coordinator.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import UIKit

// Info about Coordinators ↓
// https://medium.com/sudo-by-icalia-labs/ios-architecture-mvvm-c-coordinators-3-6-3960ad9a6d85
// https://www.raywenderlich.com/158-coordinator-tutorial-for-ios-getting-started

class Coordinator {
    
    // MARK: - Properties
    
    private(set) var childCoordinators = [Coordinator]()
    
    weak var parentCoordinator: Coordinator?
    weak var presenter: UINavigationController?
    
    // MARK: - Initialization
    
    deinit {
        presenter?.dismiss(animated: true)
    }
    
    // MARK: - Methods
    
    func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    func finish() {
        parentCoordinator?.removeChildCoordinator(self)
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.index(of: coordinator) {
            childCoordinators.remove(at: index)
        } else {
            fatalError("Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
        }
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

extension Coordinator: SystemMessagePresenter {
    func showSystemMessage(_ title: String?, message: String? = nil, completion: (() -> Void)? = nil) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        
        alertVC.addAction(cancelAction)
        
        presenter?.present(alertVC, animated: true)
    }
}

extension Coordinator: BackButtonDelegate {
    func backTap() {
        presenter?.popViewController(animated: true)
    }
}

extension Coordinator: Equatable {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}
