//
//  GameObjectNode.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 9/23/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

//
//  GameObjectNode.swift
//  RexyJump
//
//  Created by P D Leonard on 10/14/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import SpriteKit

struct CollisionCategoryBitmask {
    static let None: UInt32 = 0x1 << 0
    static let Player: UInt32 = 0x1 << 1
    static let Star: UInt32 = 0x1 << 2
    static let Platform: UInt32 = 0x1 << 3
}

enum PlatformType: Int {
    case Normal = 0
    case Break
}

enum StarType: Int {
    case Normal = 0
    case Special
}

class GameObjectNode: SKNode {
    
    func collisionWithPlayer(player: SKNode) -> Bool {
        return false
    }
    
    func checkNodeRemoval(playerY: CGFloat) {
        if playerY > self.position.y + 300.0 {
            self.removeFromParent()
        }
    }
}

class PlatformNode: GameObjectNode {
    var platformType: PlatformType!
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
        if let dy = player.physicsBody?.velocity.dy {
            if dy < CGFloat(0) {
                player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 250.0)
                if platformType == .Break {
                    self.removeFromParent()
                }
            }
            
        }
        return false
    }
}

class StarNode: GameObjectNode {
    var starType: StarType!
    let starSound = SKAction.playSoundFileNamed("StarPing.wav", waitForCompletion: false)
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
        player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 400.0)
        
        run(starSound, completion: {
            self.removeFromParent()
        })
        GameState.sharedInstance.score += (starType == .Normal ? 20 : 100)
        GameState.sharedInstance.stars += (starType == .Normal ? 1 : 5)
        return true
    }
}

class Player: SKNode {
    let sprite = SKSpriteNode(imageNamed: "Player")
    class var sharedInstance: Player {
        struct Singleton {
            static let instance = Player()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        setupPlayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPlayer() {
        addChild(sprite)
        physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        physicsBody?.isDynamic = false
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 1
        physicsBody?.friction = 0
        physicsBody?.angularDamping = 0
        physicsBody?.linearDamping = 0
        physicsBody?.categoryBitMask = CollisionCategoryBitmask.Player
        physicsBody?.collisionBitMask = 0
        physicsBody?.usesPreciseCollisionDetection = true
        physicsBody?.contactTestBitMask = CollisionCategoryBitmask.Star | CollisionCategoryBitmask.Platform
    }
    
}
