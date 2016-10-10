//
//  GameViewController.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 10/7/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

//
//  GameViewController.swift
//  JumpyJump
//
//  Created by P D Leonard on 10/7/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as! SKView
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFit
        
        skView.presentScene(scene)
    }
    
}
