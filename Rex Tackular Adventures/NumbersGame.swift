//
//  OneThroughTenViewController.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 9/4/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import Material

class NumbersGame: UIViewController {
    var number = Int()
    let titleLabel = UILabel()
    var startNumber = 0
    var endNumber: Int!

    convenience init(start: Int, end: Int) {
        self.init()
        startNumber = start
        endNumber = end
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        number = startNumber
        setupLabel()
    }

    func setupLabel() {

        titleLabel.font = UIFont(name: "Chalkduster", size: 350)
        titleLabel.textColor = MaterialColor.white
        titleLabel.text = String(number)
        view.layout(titleLabel).centerHorizontally().centerVertically()
        view.addSubview(titleLabel)
        view.backgroundColor = MaterialColor.green.darken4
        let crateGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(crateGesture)
    }

    func viewTapped() {
        number >= endNumber ? number = startNumber : (number += 1)
        titleLabel.text = String(number)
    }

}
