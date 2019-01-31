//
//  FraudsViewController.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 31/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class FraudsViewController: UIViewController, StoryboardInstantiable {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var viewModel: FraudsViewModelType!
    
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
        
        let input = FraudsViewModelInput(backTap: backButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input)
        
        output.items
            .bind(to: tableView.rx.items) { tableView, _, item in
                let identifier = "Cell"
                var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                if cell == nil {
                    cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
                }
                cell?.textLabel?.text = item.comment
                cell?.textLabel?.numberOfLines = 0
                cell?.detailTextLabel?.text = item.date
                return cell!
            }
            .disposed(by: bag)
    }
}
