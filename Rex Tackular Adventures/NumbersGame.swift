//
//  OneThroughTenViewController.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 9/4/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import AVFoundation
import Material

class NumbersGame: UIViewController, Speakable {
    var number = Int()
    let titleLabel = UILabel()
    var synth = AVSpeechSynthesizer()
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
        titleLabel.textColor = UIColor.white
        titleLabel.text = String(number)
        view.layout(titleLabel).centerHorizontally().centerVertically()
        view.addSubview(titleLabel)
        view.backgroundColor = UIColor.green
        let crateGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(crateGesture)
    }

    func viewTapped() {
        number >= endNumber ? number = startNumber : (number += 1)
        titleLabel.text = String(number)
        speak(string: String(number))
    }

}
