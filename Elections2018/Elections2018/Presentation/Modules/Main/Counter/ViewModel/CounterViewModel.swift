//
//  CounterViewModel.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class CounterViewModel: CounterViewModelType {
    
    private let saveService: SaveServiceType
    private weak var coordinator: CounterCoordinationDelegate?
    
    private let visitors = BehaviorRelay(value: [VisitorInfo]())
    
    init(saveService: SaveServiceType, coordinator: CounterCoordinationDelegate) {
        self.saveService = saveService
        self.coordinator = coordinator
        setup()
    }
    
    private var terminalText: Driver<String> {
        return visitors.map { String($0.count) }.asDriver(onErrorJustReturn: "Error")
    }
    
    private var visitorsAreAvailable: Driver<Bool> {
        return visitors.map { $0.count > 0 }.asDriver(onErrorJustReturn: false)
    }
    
    private var fraudsButtonIsAvailable: Driver<Bool> {
        return saveService.allFrauds()
            .map { $0.count > 0 }
            .asDriver(onErrorJustReturn: false)
    }
    
    private let bag = DisposeBag()
    
    private func setup() {
        saveService.allVisitors().bind(to: visitors).disposed(by: bag)
    }
    
    func transform(_ input: Input) -> Output {
        
        input.visitorsTap.subscribe(onNext: { [weak self] _ in
            self?.coordinator?.visitsTap()
        }).disposed(by: bag)
        
        input.fraudsTap.subscribe(onNext: { [weak self] _ in
            self?.coordinator?.fraudsTap()
        }).disposed(by: bag)
        
        input.registerFraudTap.subscribe(onNext: { [weak self] _ in
            self?.coordinator?.registerFraudTap()
        }).disposed(by: bag)
        
        input.addVisitorTap.subscribe(onNext: { [weak self] _ in
            self?.addVisitor()
        }).disposed(by: bag)
        
        input.removeVisitorTap.subscribe(onNext: { [weak self] _ in
            self?.removeLastVisitor()
        }).disposed(by: bag)
        
        input.resetTap.subscribe(onNext: { [weak self] _ in
            self?.reset()
        }).disposed(by: bag)
        
        return Output(terminalText: terminalText,
                      visitorsButtonIsAvailable: visitorsAreAvailable,
                      fraudsButtonIsAvailable: fraudsButtonIsAvailable,
                      removeVisitorButtonIsAvailable: visitorsAreAvailable,
                      resetButtonIsAvailable: visitorsAreAvailable)
    }
    
    private func addVisitor() {
        let info = VisitorInfo(identifier: UUID().uuidString, date: Date())
        saveService.saveVisitor(info).subscribe(onError: { [weak self] error in
            self?.showError(error)
        }).disposed(by: bag)
    }
    
    private func removeLastVisitor() {
        saveService.removeLastVisitor().subscribe(onError: { [weak self] error in
            self?.showError(error)
        }).disposed(by: bag)
    }
    
    private func reset() {
        saveService.removeAll().subscribe { [weak self] error in
            self?.showError(error)
        }.disposed(by: bag)
    }
    
    private func showError(_ error: Error) {
        coordinator?.showSystemMessage(error.localizedDescription,
                                       message: nil,
                                       completion: nil)
    }
}
