//
//  LettersGame.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 9/9/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import AVFoundation
import Material

class LettersGame: UIViewController, Speakable {
    var currentLetter = UnicodeScalar("a")
    let titleLabel = UILabel()
    var synth = AVSpeechSynthesizer()
    private var startValue = UnicodeScalar("a")
    private var endValue = UnicodeScalar("z")

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        currentLetter = startValue
        speak(string: "The current letter is " + String(describing: currentLetter) + ". Touch the screen to see the next letter.")
        setupLabel()
    }
    
    func setupLabel() {
        titleLabel.font = UIFont(name: "Chalkduster", size: 350)
        titleLabel.textColor = UIColor.white
        titleLabel.text = String(describing: currentLetter)
        view.layout(titleLabel).centerHorizontally().centerVertically()
        view.addSubview(titleLabel)
        view.backgroundColor = UIColor.blue
        let crateGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(crateGesture)
    }
    
    func viewTapped() {
        String(describing: currentLetter) >= String(describing: endValue) ? currentLetter = startValue : (currentLetter = UnicodeScalar((currentLetter?.value)! + 1))
        speak(string: String(describing: currentLetter))
        titleLabel.text = String(describing: currentLetter)
    }
    
}
