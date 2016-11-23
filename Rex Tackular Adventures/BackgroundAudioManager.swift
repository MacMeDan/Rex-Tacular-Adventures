//
//  backgroundAudioManager.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 11/4/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import AVFoundation

var backgroundMusicPlayer = AVAudioPlayer()
let jungleAudioFileName = "jungleSounds"

class BGAudio: NSObject {
    static let shared = BGAudio()
    let audioSession = AVAudioSession.sharedInstance()

    override init() {
        super.init()
        setupAudioSession()
    }
    
    func setupAudioSession() {
        do {
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
        } catch {
            assertionFailure("AVAudioSession cannot be set")
        }
    }

    
    func playJungleBackground() {
        guard let url = Bundle.main.url(forResource: jungleAudioFileName, withExtension: "mp3") else { assertionFailure("Could not find file named: \(jungleAudioFileName)"); return }
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: "mp3")
                backgroundMusicPlayer.numberOfLoops = -1
                backgroundMusicPlayer.prepareToPlay()
                backgroundMusicPlayer.play()
            } catch let error as NSError {
                print(error.description)
            }
    }
    
}
