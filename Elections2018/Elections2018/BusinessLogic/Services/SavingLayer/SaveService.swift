//
//  SaveService.swift
//  Elections2018
//
//  Created by Nikita Teplyakov on 30/01/2019.
//  Copyright © 2019 HDLT. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

class SaveService: SaveServiceType {
    
    // MARK: - Visitors
    
    func allVisitors() -> Observable<[VisitorInfo]> {
        do {
            let realm = try Realm()
            let entities = realm.objects(Visitor.self)
            return Observable.collection(from: entities).map {
                try $0.map { try VisitorInfo(visitor: $0) }
                    .sorted { $0.date < $1.date }
            }
        } catch {
            return Observable.error(error)
        }
    }
    
    func saveVisitor(_ info: VisitorInfo) -> Completable {
        return Completable.create { observer -> Disposable in
            do {
                try autoreleasepool {
                    let realm = try Realm()
                    let entity = Visitor(info: info)
                    try realm.write {
                        realm.add(entity, update: true)
                    }
                    observer(.completed)
                }
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func removeVisitor(_ info: VisitorInfo) -> Completable {
        return Completable.create { observer -> Disposable in
            do {
                try autoreleasepool {
                    let realm = try Realm()
                    if let entity = realm.objects(Visitor.self).first(where: {
                        $0.identifier == info.identifier
                    }) {
                        try realm.write {
                            realm.delete(entity)
                        }
                        observer(.completed)
                    } else {
                        observer(.error(SaveServiceError.nonexistantEntity))
                    }
                }
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func removeLastVisitor() -> Completable {
        return Completable.create { observer -> Disposable in
            do {
                try autoreleasepool {
                    let realm = try Realm()
                    let defaultDate = Date()
                    if let entity = realm.objects(Visitor.self).max(by: {
                        $0.date ?? defaultDate > $1.date ?? defaultDate
                    }) {
                        try realm.write {
                            realm.delete(entity)
                        }
                        observer(.completed)
                    } else {
                        observer(.error(SaveServiceError.nonexistantEntity))
                    }
                }
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Frauds
    func allFrauds() -> Observable<[FraudInfo]> {
        do {
            let realm = try Realm()
            let entities = realm.objects(Fraud.self)
            return Observable.collection(from: entities).map {
                try $0.map { try FraudInfo(fraud: $0) }
                    .sorted { $0.date < $1.date }
            }
        } catch {
            return Observable.error(error)
        }
    }
    
    func saveFraud(_ info: FraudInfo) -> Completable {
        return Completable.create { observer -> Disposable in
            do {
                try autoreleasepool {
                    let realm = try Realm()
                    let entity = Fraud(info: info)
                    try realm.write {
                        realm.add(entity, update: true)
                    }
                    observer(.completed)
                }
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func removeFraud(_ info: FraudInfo) -> Completable {
        return Completable.create { observer -> Disposable in
            do {
                try autoreleasepool {
                    let realm = try Realm()
                    if let entity = realm.objects(Fraud.self).first(where: {
                        $0.identifier == info.identifier
                    }) {
                        try realm.write {
                            realm.delete(entity)
                        }
                        observer(.completed)
                    } else {
                        observer(.error(SaveServiceError.nonexistantEntity))
                    }
                }
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Other methods
    
    func removeAll() -> Completable {
        return Completable.create { observer -> Disposable in
            do {
                try autoreleasepool {
                    let realm = try Realm()
                    try realm.write {
                        realm.deleteAll()
                    }
                    observer(.completed)
                }
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}
