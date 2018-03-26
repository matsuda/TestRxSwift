//
//  Rx+Transform.swift
//  TestRxSwift
//
//  Created by matsuda on 2018/03/26.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import Foundation
import RxSwift

class RxTransform {
    class func start() {
        RxTransform().start11()
    }

    func start11() {
        let s = Variable(0)
        let t = Variable(10)
        let u = Variable(s.asObservable())
        _ = u.asObservable()
        .switchLatest()
            .subscribe({
                print($0)
            })

        s.value = 1
        s.value = 2
        u.value = t.asObservable()
        t.value = 11
        t.value = 12
        s.value = 3
        s.value = 4
    }
    func start10() {
        let s = PublishSubject<Int>()
        let t = PublishSubject<Int>()
        _ = Observable.of(s,t)
        .merge()
            .subscribe({
                print($0)
            })

        s.onNext(1)
        t.onNext(2)
        s.onNext(1)
        s.onNext(1)
        t.onNext(2)
    }
    func start9() {
        let s = Observable.from(0...4)
        let t = Observable.from(["a","b","c"])
        _ = Observable.zip(s, t, resultSelector: {
            "\($0)\($1)"
        })
            .subscribe({
                print($0)
            })
    }
    func start8() {
        let s = PublishSubject<Int>()
        let t = PublishSubject<String>()
        _ = Observable.combineLatest(s, t, resultSelector: {
            "\($0)\($1)"
        })
            .subscribe({
                print($0)
            })
        s.onNext(1)
        t.onNext("a")
        s.onNext(2)
        t.onNext("b")
    }
    func start7() {
        let stream = Observable.from([2,3])
        _ = stream
        .startWith(1)
        .startWith(0)
            .subscribe({
                print($0)
            })
    }
    func start6() {
        let stream = Observable.from([1,2,3,1,1,4])
        _ = stream
        .take(2)
            .subscribe({
                print($0)
            })
    }
    func start5() {
        let stream = Observable.from([1,2,3,1,1,4])
        _ = stream
        .distinctUntilChanged()
            .subscribe({
                print($0)
            })
    }
    func start4() {
        let stream = Observable.from(1..<10)
        _ = stream
            .filter({ (x) -> Bool in
                x % 2 == 0
            })
            .subscribe({
                print($0)
            })
    }
    func start3() {
        let stream = Observable.of(0,1,2,3)
        _ = stream
            .scan(0, accumulator: { (acum, elem) -> Int in
                acum + elem
            })
            .subscribe({
                print($0)
            })
    }
    func start2() {
        let stream = Observable.from(1..<30)
        _ = stream
            .flatMap({ (x: Int) -> Observable<UnicodeScalar> in
                if case (1..<27) = x {
                    return Observable.just(UnicodeScalar(x + 64)!)
                } else {
                    return Observable.empty()
                }
            })
            .subscribe({
                print($0)
            })
    }
    func start() {
        let stream = Observable.from(65..<70)
        _ = stream
            .map({ (x) in
                UnicodeScalar(x)
            })
            .subscribe({
                print($0)
            })
    }
}
