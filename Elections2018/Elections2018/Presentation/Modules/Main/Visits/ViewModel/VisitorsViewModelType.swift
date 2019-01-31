//
//  VisitorsViewModelType.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 31/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation
import RxSwift

struct VisitorsViewModelInput {
    let backTap: Observable<Void>
}

struct VisitorsViewModelOutput {
    let items: Observable<[VisitorItem]>
}

protocol VisitorsViewModelType: class {
    
    typealias Input = VisitorsViewModelInput
    typealias Output = VisitorsViewModelOutput
    
    func transform(_ input: Input) -> Output
}
