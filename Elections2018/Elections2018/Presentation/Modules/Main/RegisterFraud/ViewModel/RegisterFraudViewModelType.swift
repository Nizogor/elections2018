//
//  RegisterFraudViewModelType.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 31/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

struct RegisterFraudViewModelInput {
    let confirmationTap: Observable<Void>
    let backTap: Observable<Void>
    let input: Observable<String>
}

struct RegisterFraudViewModelOutput {
    let confirmationButtonIsAvailable: Driver<Bool>
}

protocol RegisterFraudViewModelType: class {
    
    typealias Input = RegisterFraudViewModelInput
    typealias Output = RegisterFraudViewModelOutput
    
    func transform(_ input: Input) -> Output
}
