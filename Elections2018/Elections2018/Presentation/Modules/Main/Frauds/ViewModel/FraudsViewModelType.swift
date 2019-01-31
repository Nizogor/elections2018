//
//  FraudsViewModelType.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 31/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation
import RxSwift

struct FraudsViewModelInput {
    let backTap: Observable<Void>
}

struct FraudsViewModelOutput {
    let items: Observable<[FraudItem]>
}

protocol FraudsViewModelType: class {
    
    typealias Input = FraudsViewModelInput
    typealias Output = FraudsViewModelOutput
    
    func transform(_ input: Input) -> Output
}
