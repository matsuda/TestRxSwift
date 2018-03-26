//
//  Rx+Condition.swift
//  TestRxSwift
//
//  Created by matsuda on 2018/03/27.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import Foundation
import RxSwift

class RxCondition {
    class func start() {
        RxCondition().start7()
    }

    func start7() {
        let stream = Observable.from(0..<10)
        _ = stream
            .reduce(0, accumulator: +)
            .subscribe({
                print($0)
            })
     }
    func start6() {
        let s1 = Observable.from([0,1,2])
        let s2 = Observable.from([5,6,7,8])
        _ = s1.concat(s2)
            .subscribe({
                print($0)
            })
    }
    func start5() {
        let stream = Observable.from(0..<10)
        _ = stream
            .takeWhile({ x in
                x < 4
            })
            .subscribe({
                print($0)
            })
    }
    func start4() {
        let s1 = PublishSubject<Int>()
        let s2 = PublishSubject<Int>()

        _ = s1
        .takeUntil(s2)
            .subscribe({
                print($0)
            })

        s1.onNext(1)
        s1.onNext(2)
        s1.onNext(3)
        s1.onNext(4)
        s2.onNext(1)
        s1.onNext(5)
    }
    func start3() {
        let stream = Observable.from(0...6)
        _ = stream
            .do(onNext: {
                print("intercepted", $0)
            })
            .filter({
                $0 % 2 == 0
            })
            .subscribe({
                print($0)
            })
    }
    func start2() {
        var counter = 1
        let stream = Observable<Int>.create { (observer) -> Disposable in
            observer.onNext(0)
            observer.onNext(1)
            observer.onNext(2)
            if counter < 2 {
                let error = NSError(domain: "Test", code: 0, userInfo: nil)
                observer.onError(error)
                counter += 1
            }
            observer.onNext(3)
            observer.onNext(4)
            observer.onNext(5)
            observer.onCompleted()
            return Disposables.create()
        }
        _ = stream
        .retry()
            .subscribe({
                print($0)
            })
    }
    func start() {
        let s = PublishSubject<Int>()
        _ = s
            .catchError({ (error) -> Observable<Int> in
                return Observable.from([10,11,12])
            })
            .subscribe({
                print($0)
            })

        s.onNext(1)
        s.onNext(2)
        s.onNext(3)
        s.onError(NSError(domain: "Test", code: 0, userInfo: nil))
    }
}
