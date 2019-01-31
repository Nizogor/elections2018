//
//  CounterViewModelType.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

struct CounterViewModelInput {
    
    let visitorsTap: Observable<Void>
    let fraudsTap: Observable<Void>
    
    let registerFraudTap: Observable<Void>
    
    let addVisitorTap: Observable<Void>
    let removeVisitorTap: Observable<Void>
    
    let resetTap: Observable<Void>
}

struct CounterViewModelOutput {
    
    let terminalText: Driver<String>
    
    let visitorsButtonIsAvailable: Driver<Bool>
    let fraudsButtonIsAvailable: Driver<Bool>
    
    let removeVisitorButtonIsAvailable: Driver<Bool>
    
    let resetButtonIsAvailable: Driver<Bool>
}

protocol CounterViewModelType: class {
    
    typealias Input = CounterViewModelInput
    typealias Output = CounterViewModelOutput
    
    func transform(_ input: CounterViewModelInput) -> CounterViewModelOutput
}
