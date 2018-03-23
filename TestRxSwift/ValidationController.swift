//
//  ValidationController.swift
//  TestRxSwift
//
//  Created by matsuda on 2018/03/23.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ValidationController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var button: UIButton!

    let disposeBag = DisposeBag()
    let throttleInterval = 0.1

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }

    func subscribe() {
        let emailValid = emailField.rx.text
            .throttle(throttleInterval, scheduler: MainScheduler.instance)
            .map { self.validate(email: $0) }
            .share(replay: 1, scope: .whileConnected)

        emailValid
            .subscribe(onNext: {
                self.emailField.isValid = $0
            })
            .disposed(by: disposeBag)

        let passwordValid = passwordField.rx.text
            .throttle(throttleInterval, scheduler: MainScheduler.instance)
            .map { self.validate(password: $0) }
            .share(replay: 1, scope: .whileConnected)

        passwordValid
            .subscribe(onNext: {
                self.passwordField.isValid = $0
            })
            .disposed(by: disposeBag)

        Observable.combineLatest(emailValid, passwordValid) { $0 && $1 }
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)

        button.rx.tap
            .bind {
                let alert = UIAlertController(title: "Success", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }

    func validate(email: String?) -> Bool {
        guard let text = email else {
            return false
        }
        return text.count >= 4
    }

    func validate(password: String?) -> Bool {
        guard let text = password else {
            return false
        }
        return text.count >= 4
    }
}

extension UITextField {
    var isValid: Bool {
        get {
            return backgroundColor == .clear
        }
        set {
            backgroundColor = newValue ? .clear : .red
        }
    }
}
