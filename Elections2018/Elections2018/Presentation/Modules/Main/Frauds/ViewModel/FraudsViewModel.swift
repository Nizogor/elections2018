//
//  FraudsViewModel.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 31/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation
import RxSwift

class FraudsViewModel: FraudsViewModelType {
    
    private let saveService: SaveServiceType
    private weak var coordinator: BackButtonDelegate?
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter
    }()
    
    private let bag = DisposeBag()
    
    init(saveService: SaveServiceType, coordinator: BackButtonDelegate) {
        self.saveService = saveService
        self.coordinator = coordinator
    }
    
    func transform(_ input: Input) -> Output {
        
        input.backTap.subscribe(onNext: { [weak self] _ in
            self?.coordinator?.backTap()
        }).disposed(by: bag)
        
        let items = saveService.allFrauds()
            .map {
                $0.map { [weak self] info -> FraudItem in
                    let date = self?.dateFormatter.string(from: info.date) ?? ""
                    return FraudItem(date: date, comment: info.comment)
                }
        }
        
        return Output(items: items)
    }
}

