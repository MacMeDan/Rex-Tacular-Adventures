//
//  JumpintViewController.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 9/23/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import CoreMotion
import SpriteKit
import GameKit

class JumpintViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = self.view as! SKView

        skView.showsFPS = true
        skView.showsNodeCount = true

        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFit
        
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

  }
