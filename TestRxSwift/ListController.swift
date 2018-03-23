//
//  ListController.swift
//  TestRxSwift
//
//  Created by matsuda on 2018/03/23.
//  Copyright © 2018年 matsuda. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// http://amarron.blog/detail.php?id=20171202
class ListController: UIViewController {

    let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }

    func subscribe() {
        Observable.just(Animal.all())
            .bind(to: tableView.rx.items(cellIdentifier: AnimalCell.identifier, cellType: AnimalCell.self)) { row, item, cell in
                cell.configureCell(animal: item)
            }
            .disposed(by: disposeBag)

        tableView.rx
            .modelSelected(Animal.self)
            .subscribe(onNext: { (item) in
                let alert = UIAlertController(title: item.name, message: item.emoji, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: indexPath, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}

class AnimalCell: UITableViewCell {
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    static let identifier = "AnimalCell"

    func configureCell(animal: Animal) {
        nameLabel.text = animal.name
        emojiLabel.text = animal.emoji
    }
}

struct Animal {
    let name: String
    let emoji: String

    static func all() -> [Animal] {
        return [
            Animal(name: "Dog", emoji: "🐶"),
            Animal(name: "Cat", emoji: "🐱"),
            Animal(name: "Monkey", emoji: "🐵")
        ]
    }
}
