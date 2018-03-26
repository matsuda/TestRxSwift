//
//  Rx+Create.swift
//  TestRxSwift
//
//  Created by matsuda on 2018/03/26.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import Foundation
import RxSwift

// http://tiny-wing.hatenablog.com/entry/2016/01/02/161322
class RxCreate {
    class func start() {
        RxCreate().start()
    }
    func start() {
        let emptyStream: Observable<Int> = Observable.empty()
        _ = emptyStream
            .subscribe { (event) in
                print("empty:", event)
        }
        let neverStream: Observable<String> = Observable.never()
        _ = neverStream
            .subscribe({ (event) in
                print("never:", event)
            })
        let justStream = Observable.just(32)
        _ = justStream
            .subscribe({ (event) in
                print("just:", event)
            })
        let ofStream = Observable.of(0,1,2)
        _ = ofStream
            .subscribe({ (event) in
                print("of:", event)
            })
        // [1,2,3].toObservable() replaced
        let arrayStream = Observable.from([1,2,3])
        _ = arrayStream
            .subscribe({ (event) in
                print("from:", event)
            })
        let myJust = { (element: Int) -> Observable<Int> in
            return Observable.create({ (observer) -> Disposable in
                observer.on(.next(element))
                observer.on(.completed)
                return Disposables.create()
            })
        }
        _ = myJust(32)
            .subscribe { (event) in
                print("myJust:", event)
        }
        let error = NSError(domain: "Error Test", code: -1, userInfo: nil)
        let errorStream: Observable<Int> = Observable.error(error)
        _ = errorStream
            .subscribe({ (event) in
                print("error:", error)
            })
        let deferredStrem: Observable<Int> = Observable.deferred { () -> Observable<Int> in
            print("creating")
            return Observable.create({ (observer) -> Disposable in
                print("emitting")
                observer.on(.next(0))
                observer.on(.next(1))
                return Disposables.create()
            })
        }
        print("first deferred")
        _ = deferredStrem
            .subscribe({ (event) in
                print("first deferred:", event)
            })
        print("second deferred")
        _ = deferredStrem
            .subscribe({ (event) in
                print("second deferred:", event)
            })
    }
}
