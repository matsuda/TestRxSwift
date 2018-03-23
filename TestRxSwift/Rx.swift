//
//  Rx.swift
//  TestRxSwift
//
//  Created by matsuda on 2018/03/23.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import Foundation
import RxSwift

class RxSample {
    let disposeBag = DisposeBag()

    static func start() {
        RxSample().start()
    }

//    var observer: (Event<Int>) -> Void = { (event) in
//        switch event {
//        case .next(let e):
//            print("next >>>", e)
//        case .error(let e):
//            print("error >>>", e)
//        case .completed:
//            print("completed")
//        }
//    }

    func observer<T>() -> ((Event<T>) -> Void) {
        return { (event) in
            switch event {
            case .next(let e):
                print("next >>>", e)
            case .error(let e):
                print("error >>>", e)
            case .completed:
                print("completed")
            }
        }
    }
}

extension RxSample {
    func start() {
        Observable.of("dog","cat")
            .subscribe(observer())
            .disposed(by: disposeBag)
        Observable.just([1,2])
            .subscribe(observer())
            .disposed(by: disposeBag)
    }
}
