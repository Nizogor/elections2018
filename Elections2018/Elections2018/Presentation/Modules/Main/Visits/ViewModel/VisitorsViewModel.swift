//
//  VisitorsViewModel.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 31/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation
import RxSwift

class VisitorsViewModel: VisitorsViewModelType {
    
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
        
        let items = saveService.allVisitors()
            .map {
                $0.map { [weak self] info -> VisitorItem in
                    let date = self?.dateFormatter.string(from: info.date) ?? ""
                    return VisitorItem(date: date)
                }
        }
        
        return Output(items: items)
    }
}
