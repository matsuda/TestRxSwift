//
//  Rx+Subjects.swift
//  TestRxSwift
//
//  Created by matsuda on 2018/03/26.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import Foundation
import RxSwift

// http://tiny-wing.hatenablog.com/entry/2016/01/11/172915
class RxSubjects {
    class func start() {
        RxSubjects().start4()
    }

    func start4() {
        do {
            let disposeBag = DisposeBag()
            let variable = Variable<String>("Initial value")
            variable.asObservable().subscribe({ (event) in
                print("subscription 1, event:", event)
            }).disposed(by: disposeBag)
            variable.value = "a"
            variable.value = "b"
            variable.asObservable().subscribe({ (event) in
                print("subscription 2, event:", event)
            }).disposed(by: disposeBag)
            variable.value = "c"
            variable.value = "d"
            print("exit scope")
        }
    }

    func start3() {
        let disposeBag = DisposeBag()
        let subject = BehaviorSubject<String>(value: "Initial value")
        subject.subscribe { (event) in
            print("subscription: 1, event:", event)
            }.disposed(by: disposeBag)
        subject.onNext("a")
        subject.onNext("b")
        subject.subscribe { (event) in
            print("subscription: 2, event:", event)
            }.disposed(by: disposeBag)
        subject.onNext("c")
        subject.onNext("d")
        subject.onCompleted()
    }

    func start2() {
        let disposeBag = DisposeBag()
        let subject = ReplaySubject<String>.create(bufferSize: 1)
        subject.subscribe { (event) in
            print("subscription: 1, event:", event)
            }.disposed(by: disposeBag)
        subject.onNext("a")
        subject.onNext("b")
        subject.subscribe { (event) in
            print("subscription: 2, event:", event)
            }.disposed(by: disposeBag)
        subject.onNext("c")
        subject.onNext("d")
    }

    func start() {
        let disposeBag = DisposeBag()
        let subject = PublishSubject<String>()
        subject.subscribe { (event) in
            print("subscription: 1, event:", event)
            }.disposed(by: disposeBag)
        subject.onNext("a")
        subject.onNext("b")
        subject.subscribe { (event) in
            print("subscription: 2, event:", event)
            }.disposed(by: disposeBag)
        subject.onNext("c")
        subject.onNext("d")
    }
}
