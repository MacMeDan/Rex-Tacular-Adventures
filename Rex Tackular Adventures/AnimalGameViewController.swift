//
//  AnimalGameViewController.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 7/31/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import AVFoundation
import Material

class AnimalGameViewController: UIViewController, Speakable {
    var crateClosed = true
    var crate = CrateAnimationsView()
    var synth = AVSpeechSynthesizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareCrate()
        addBackButton()
    }

    func prepareView() {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Chalkduster", size: 45)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "What Animal is this!"
        view.layout(titleLabel).centerHorizontally().top(20)
        view.addSubview(titleLabel)
        view.backgroundColor = UIColor.blue
        let crateGesture = UITapGestureRecognizer(target: self, action: #selector(crateTapped))
        self.view.addGestureRecognizer(crateGesture)
    }
    
    func prepareCrate() {
        crate = CrateAnimationsView(frame: view.frame)
        view.addSubview(crate)
    }
    
    func crateTapped() {
        if crateClosed {
            crate.addCloseAnimation(completion: { (Bool) in
            self.crateClosed = !self.crateClosed
            })} else  {
            crate.addOpenAnimation(completion: { (Bool) in
                self.crateClosed = !self.crateClosed
            })
        }
    }
}
