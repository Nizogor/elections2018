//
//  RegisterFraudViewController.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 31/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class RegisterFraudViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet weak var confirmationButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    var viewModel: RegisterFraudViewModelType!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
    }
    
    private func setup() {
        textField.rx.controlEvent(.primaryActionTriggered)
            .subscribe(onNext: { [weak self] _ in
                self?.textField.resignFirstResponder()
            })
            .disposed(by: bag)
    }
    
    private func bindViewModel() {
        
        let input = RegisterFraudViewModelInput(
            confirmationTap: confirmationButton.rx.tap.asObservable(),
            backTap: backButton.rx.tap.asObservable(),
            input: textField.rx.text.orEmpty.asObservable()
        )
        
        let output = viewModel.transform(input)
        
        output.confirmationButtonIsAvailable
            .distinctUntilChanged()
            .do(onNext: { [weak self] isAvailable in
                self?.confirmationButton.alpha = isAvailable ? 1 : 0.3
            })
            .drive(confirmationButton.rx.isEnabled)
            .disposed(by: bag)
    }

}
