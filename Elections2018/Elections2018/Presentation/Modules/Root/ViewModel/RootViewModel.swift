//
//  RootViewModel.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation
import RxSwift

class RootViewModel: RootViewModelType {
    
    // MARK: - Properties
    
    private weak var coordinator: RootCoordinationDelegate?
    
    private let bag = DisposeBag()
    
    // MARK: - Initialization
    
    init(coordinator: RootCoordinationDelegate) {
        self.coordinator = coordinator
    }
    
    // MARK: - Binding
    
    func viewDidAppearMethodCalled() {
        coordinator?.rootViewDidAppear()
    }
}
