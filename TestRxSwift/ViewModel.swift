//
//  ViewModel.swift
//  TestRxSwift
//
//  Created by matsuda on 2018/03/22.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    func send() {
        let request = userRequest(name: "octcat")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
//                print(json)

                let user = try JSONDecoder().decode(User.self, from: data)
                print(user)
            } catch {
                print(error)
            }
        }
        task.resume()
    }

    func rx_send<T: Decodable>() -> Observable<T> {
        return Observable<T>.create({ (observer) in
            let request = self.userRequest(name: "octcat")
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { (data, response, error) in
                let defaultError = NSError(domain: "Test Error", code: 10001, userInfo: nil)
                guard let _ = response, let data = data else {
                    observer.on(.error(error ?? defaultError))
                    return
                }
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(model)
                } catch {
                    observer.onError(error)
                    return
                }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        })
    }
    /*
    func rx_send2<T: Decodable>() -> Observable<T> {
        let request = self.userRequest(name: "octcat")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let response = session.rx.response(request: request)
    }
    */

    private func userRequest(name: String) -> URLRequest {
        let url = "https://api.github.com/users/" + name
        return URLRequest(url: URL(string: url)!)
    }
}
