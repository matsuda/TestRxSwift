//
//  Rx+Connectable.swift
//  TestRxSwift
//
//  Created by matsuda on 2018/03/28.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import Foundation
import RxSwift

class RxConnectable {
    class func start() {
        RxConnectable().start2()
    }
    func start4() {
        let s = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .publish()

        _ = s
            .subscribe({
                print("first subscription", $0)
            })

        delay(2) {
            print("-- connect --")
            s.connect()
        }

        delay(4) {
            print("-- after delay(4) --")
            _ = s
                .subscribe({
                    print("second subscription", $0)
                })
        }

        delay(6) {
            print("-- after delay(6) --")
            _ = s
                .subscribe({
                    print("third subscription", $0)
                })
        }
    }
    func start3() {
        let s = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .replay(1)

        _ = s
            .subscribe({
                print("first subscription", $0)
            })

        delay(2) {
            print("-- connect --")
            s.connect()
        }

        delay(4) {
            print("-- after delay(4) --")
            _ = s
                .subscribe({
                    print("second subscription", $0)
                })
        }

        delay(6) {
            print("-- after delay(6) --")
            _ = s
                .subscribe({
                    print("third subscription", $0)
                })
        }
    }
    func start2() {
        let subject = PublishSubject<Int>()
        _ = subject
            .subscribe({
                print("Subject", $0)
            })

        // multicast を使用して Connectable Observable を取得する
        let s = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .multicast(subject)

        _ = s
            .subscribe({
                print("first subscription", $0)
            })

        delay(2) {
            print("-- connect --")
            s.connect()
        }

        delay(4) {
            print("-- after delay(4) --")
            _ = s
                .subscribe({
                    print("second subscription", $0)
                })
        }

        delay(6) {
            print("-- after delay(6) --")
            _ = s
                .subscribe({
                    print("third subscription", $0)
                })
        }
    }
    func start() {
        let s = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        _ = s
            .subscribe({
                print("first subscription", $0)
            })
        delay(2) {
            print("-- after delay(2) --")
            _ = s
                .subscribe({
                    print("second subscription", $0)
                })
        }
    }

    private func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
    }
}
