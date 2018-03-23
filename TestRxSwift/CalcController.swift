//
//  CalcController.swift
//  TestRxSwift
//
//  Created by matsuda on 2018/03/23.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// http://amarron.blog/detail.php?id=20171202
class CalcController: UIViewController {

    let disposeBag = DisposeBag()

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var resultField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }

    func subscribe() {
        Observable.combineLatest(textField1.rx.text.orEmpty, textField2.rx.text.orEmpty) { (v1, v2) -> Int in
                (Int(v1) ?? 0) + (Int(v2) ?? 0)
            }
            .map { $0.description }
            .bind(to: resultField.rx.text)
            .disposed(by: disposeBag)
    }
}
