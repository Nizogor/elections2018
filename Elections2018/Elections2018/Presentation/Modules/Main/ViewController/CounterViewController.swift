//
//  CounterViewController.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class CounterViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet weak var terminalLabel: UILabel!
    
    @IBOutlet weak var visitorsButton: UIButton!
    @IBOutlet weak var fraudsButton: UIButton!
    
    @IBOutlet weak var registerFraudButton: UIButton!
    
    @IBOutlet weak var addVisitorButton: UIButton!
    @IBOutlet weak var removeVisitorButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    var viewModel: CounterViewModelType!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        
        let input = CounterViewModelInput(
            visitorsTap: visitorsButton.rx.tap.asObservable(),
            fraudsTap: fraudsButton.rx.tap.asObservable(),
            registerFraudTap: registerFraudButton.rx.tap.asObservable(),
            addVisitorTap: addVisitorButton.rx.tap.asObservable(),
            removeVisitorTap: removeVisitorButton.rx.tap.asObservable(),
            resetTap: resetButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input)
        
        output.terminalText
            .distinctUntilChanged()
            .drive(terminalLabel.rx.text)
            .disposed(by: bag)
        
        output.visitorsButtonIsAvailable
            .distinctUntilChanged()
            .do(onNext: { [weak self] isAvailable in
                self?.visitorsButton.alpha = isAvailable ? 1 : 0.3
            })
            .drive(visitorsButton.rx.isEnabled)
            .disposed(by: bag)
        
        output.fraudsButtonIsAvailable
            .distinctUntilChanged()
            .do(onNext: { [weak self] isAvailable in
                self?.fraudsButton.alpha = isAvailable ? 1 : 0.3
            })
            .drive(fraudsButton.rx.isEnabled)
            .disposed(by: bag)
        
        output.removeVisitorButtonIsAvailable
            .distinctUntilChanged()
            .do(onNext: { [weak self] isAvailable in
                self?.removeVisitorButton.alpha = isAvailable ? 1 : 0.3
            })
            .drive(removeVisitorButton.rx.isEnabled)
            .disposed(by: bag)
        
        output.resetButtonIsAvailable
            .distinctUntilChanged()
            .do(onNext: { [weak self] isAvailable in
                self?.resetButton.alpha = isAvailable ? 1 : 0.3
            })
            .drive(resetButton.rx.isEnabled)
            .disposed(by: bag)
    }
}
