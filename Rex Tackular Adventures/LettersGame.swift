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
        speak("The current letter is " + String(currentLetter) + ". Touch the screen to see the next letter.")
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
        speak(String(currentLetter))
        titleLabel.text = String(currentLetter)
    }
    
}
