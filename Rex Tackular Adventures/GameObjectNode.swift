//
//  GameObjectNode.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 9/23/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import SpriteKit

struct CollisionCategoryBitmask {
    static let Player: UInt32 = 0x00
    static let Star: UInt32 = 0x01
    static let Platform: UInt32 = 0x02
}

enum PlatformType: Int {
    case Normal = 0
    case Break
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

// MARK: Platforms
class PlatformNode: GameObjectNode {
    var platformType: PlatformType!

    override func collisionWithPlayer(player: SKNode) -> Bool {
        // Only bounce the player if he's falling
        if (player.physicsBody?.velocity.dy)! < CGFloat(0) {
            player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 250.0)
            if platformType == .Break {
                self.removeFromParent()
            }
        }
        return false
    }
}

// MARK: Star

enum StarType: Int {
    case Normal = 0
    case Special
}

class StarNode: GameObjectNode {
    var starType: StarType!
    let starSound = SKAction.playSoundFileNamed("StarPing.wav", waitForCompletion: false)

    override func collisionWithPlayer(player: SKNode) -> Bool {
        player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 400.0)
        run(starSound, completion: {
            self.removeFromParent()
            GameState.sharedInstance.score += (self.starType == .Normal ? 20 : 100)
            GameState.sharedInstance.stars += (self.starType == .Normal ? 1 : 5)
        })
        return true
    }
}
