//
//  VisitorsViewController.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 18.03.2018.
//  Copyright © 2018 HDLT. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class VisitorsViewController: UIViewController, StoryboardInstantiable {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: VisitorsViewModelType!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func bindViewModel() {
        
        let input = VisitorsViewModelInput(backTap: backButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input)
        
        output.items
            .bind(to: tableView.rx.items) { tableView, index, item in
                let identifier = "Cell"
                var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                if cell == nil {
                    cell = UITableViewCell(style: .value1, reuseIdentifier: identifier)
                }
                cell?.textLabel?.text = String(index + 1)
                cell?.detailTextLabel?.text = item.date
                return cell!
            }
            .disposed(by: bag)
    }
}
