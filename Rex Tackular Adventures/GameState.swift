//
//  GameState.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 9/23/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit

class GameState {
    var score: Int
    var highScore: Int
    var stars: Int

    init() {
        score = 0
        highScore = 0
        stars = 0

        let defaults = UserDefaults.standard

        highScore = defaults.integer(forKey: "highScore")
        stars = defaults.integer(forKey: "stars")
    }

    class var sharedInstance: GameState {
        struct Singleton {
            static let instance = GameState()
        }

        return Singleton.instance
    }

    func saveState() {
        highScore = max(score, highScore)

        let defaults = UserDefaults.standard
        defaults.set(highScore, forKey: "highScore")
        defaults.set(stars, forKey: "stars")
        UserDefaults.standard.synchronize()
    }
}
