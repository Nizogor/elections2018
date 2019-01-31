//
//  RegisterFraudViewModel.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 31/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class RegisterFraudViewModel: RegisterFraudViewModelType {
    
    private let saveService: SaveServiceType
    private weak var coordinator: RegisterFraudCoordinationDelegate?
    
    private let bag = DisposeBag()
    
    init(saveService: SaveServiceType, coordinator: RegisterFraudCoordinationDelegate) {
        self.saveService = saveService
        self.coordinator = coordinator
    }
    
    func transform(_ input: Input) -> Output {
        
        input.confirmationTap.withLatestFrom(input.input)
            .subscribe(onNext: { [weak self] input in
                self?.saveFraud(input)
            })
            .disposed(by: bag)
        
        input.backTap.subscribe(onNext: { [weak self] _ in
            self?.coordinator?.backTap()
        }).disposed(by: bag)
        
        let confirmationButtonIsAvailable = input.input
            .map { $0.count > 0 }.asDriver(onErrorJustReturn: false)
        
        return Output(confirmationButtonIsAvailable: confirmationButtonIsAvailable)
    }
    
    private func saveFraud(_ input: String) {
        
        let identifier = UUID().uuidString
        let date = Date()
        let info = FraudInfo(identifier: identifier, date: date, comment: input)
        
        saveService.saveFraud(info)
            .subscribe(onCompleted: { [weak self] in
                self?.coordinator?.backTap()
                }, onError: { [weak self] error in
                    self?.coordinator?.showSystemMessage(error.localizedDescription,
                                                         message: nil,
                                                         completion: nil)
            })
            .disposed(by: bag)
    }
}
