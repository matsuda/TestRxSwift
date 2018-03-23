//
//  ViewController.swift
//  TestRxSwift
//
//  Created by matsuda on 2018/03/22.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    var vm: ViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        setupVM()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension ViewController {
    func setupVM() {
        vm = ViewModel()
//        vm.send()
        vm.rx_send()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (m: User) -> Void in
                print("next >>>", m)
                print("thread >>>", Thread.isMainThread)
            }, onError: { (error) in
                print("error >>>", error)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            })
        .disposed(by: disposeBag)
    }
}
