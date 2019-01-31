//
//  SaveServiceType.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation
import RxSwift

protocol SaveServiceType: class {
    
    func allVisitors() -> Observable<[VisitorInfo]>
    func saveVisitor(_ visitor: VisitorInfo) -> Completable
    func removeVisitor(_ visitor: VisitorInfo) -> Completable
    func removeLastVisitor() -> Completable
    
    func allFrauds() -> Observable<[FraudInfo]>
    func saveFraud(_ fraud: FraudInfo) -> Completable
    func removeFraud(_ fraud: FraudInfo) -> Completable
    
    func removeAll() -> Completable
}
