//
//  LettersGame.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 9/9/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import Material
import AVFoundation

class LettersGame: UIViewController {
    var currentLetter = UnicodeScalar("a")
    let titleLabel = UILabel()

    private var startValue = UnicodeScalar("a")
    private var endValue = UnicodeScalar("z")
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        currentLetter = startValue
        setupLabel()
    }

    func setupLabel() {
        titleLabel.font = UIFont(name: "Chalkduster", size: 350)
        titleLabel.textColor = MaterialColor.white
        titleLabel.text = String(currentLetter)
        view.layout(titleLabel).centerHorizontally().centerVertically()
        view.addSubview(titleLabel)
        view.backgroundColor = MaterialColor.blue.darken4
        let crateGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(crateGesture)
    }
    
    func viewTapped() {
        currentLetter >= endValue ? currentLetter = startValue : (currentLetter = UnicodeScalar(currentLetter.value + 1))
        myUtterance = AVSpeechUtterance(string: String(currentLetter))
        myUtterance.rate = 0.3
        synth.speakUtterance(myUtterance)
        titleLabel.text = String(currentLetter)
    }

    
}
