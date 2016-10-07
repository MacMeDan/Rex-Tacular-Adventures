//
//  Speakable.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 9/9/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import AVFoundation

protocol Speakable {
    var synth: AVSpeechSynthesizer { get set }//= AVSpeechSynthesizer()
    func speak(string: String)
}

extension Speakable where Self:UIViewController {
    func speak(string: String) {
        let myUtterance = AVSpeechUtterance(string: string)
        myUtterance.rate = 0.3
        myUtterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        synth.pauseSpeaking(at: .word)
        synth.speak(myUtterance)
    }
}

