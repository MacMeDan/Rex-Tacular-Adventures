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
    let titleLabel = UILabel()
    var crate = CrateAnimationsView()
    var synth = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareCrate()
        addBackButton()
    }

    func prepareView() {
        let background = UIImageView(frame: view.frame)
        background.image = #imageLiteral(resourceName: "jungleBackground")
        BGAudio.shared.playJungleBackground()
        background.contentMode = .scaleAspectFill
        titleLabel.font = UIFont(name: "Chalkduster", size: 45)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "What Animal is this!"
        view.layout(titleLabel).centerHorizontally().top(20)
        view.addSubview(titleLabel)
        view.addSubview(background)
        view.layout(background).top().bottom().left().right()
        let crateGesture = UITapGestureRecognizer(target: self, action: #selector(crateTapped))
        self.view.addGestureRecognizer(crateGesture)
    }
    
    func prepareCrate() {
        crate = CrateAnimationsView(frame: view.frame)
        view.addSubview(crate)
    }
    
    func crateTapped() {
        crateClosed ? crate.addOpenAnimation() : crate.addCloseAnimation()
        crateClosed = !crateClosed
        if !crateClosed {
            self.crate.dancingAnimal.reset()
        }
    }
    
}
