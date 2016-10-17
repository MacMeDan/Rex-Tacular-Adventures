//
//  GameScene.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 9/23/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    var backgroundNode: SKNode!
    var midgroundNode: SKNode!
    var foregroundNode: SKNode!
    var hudNode: SKNode!
    
    // Player
    let player = Player()
    
    // Tap To Start node
    var tapToStartNode = SKSpriteNode(imageNamed: "TapToStart")
    
    // Height at which level ends
    var endLevelY = 0
    
    // Motion manager for accelerometer
    let motionManager = CMMotionManager()
    
    // Acceleration value from accelerometer
    var xAcceleration: CGFloat = 0.0
    
    // Labels for score and stars
    var lblScore: SKLabelNode!
    var lblStars: SKLabelNode!
    
    // Max y reached by player
    var maxPlayerY: Int!
    
    // Game over dude!
    var gameOver = false
    
    // To Accommodate iPhone 6
    var scaleFactor: CGFloat!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = SKColor.white
        scaleFactor = self.size.width / 320.0
        
        maxPlayerY = 80
        GameState.sharedInstance.score = 0
        gameOver = false
        
        backgroundNode = createBackgroundNode()
        addChild(backgroundNode)
        
        midgroundNode = createMidgroundNode()
        addChild(midgroundNode)
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        
        physicsWorld.contactDelegate = self
        
        foregroundNode = SKNode()
        addChild(foregroundNode)
        
        // HUD
        hudNode = SKNode()
        addChild(hudNode)
        
        let levelPlist = Bundle.main.path(forResource: "Level01", ofType: "plist")
        let levelData = NSDictionary(contentsOfFile: levelPlist!)!
        
        endLevelY = (levelData["EndY"]! as AnyObject).integerValue!
        
        let platforms = levelData["Platforms"] as! NSDictionary
        let platformPatterns = platforms["Patterns"] as! NSDictionary
        let platformPositions = platforms["Positions"] as! [NSDictionary]
        
        for platformPosition: NSDictionary in platformPositions {
            let patternX = platformPosition["x"] as! Float
            let patternY = platformPosition["y"] as! Float
            let pattern = platformPosition["pattern"] as! NSString
            
            let platformPattern = platformPatterns[pattern] as! [NSDictionary]
            for platformPoint in platformPattern {
                let x = platformPoint["x"] as! Float
                let y = platformPoint["y"] as! Float
                let type = PlatformType(rawValue: platformPoint["type"] as! Int)
                let positionX = CGFloat(x + patternX)
                let positionY = CGFloat(y + patternY)
                let platformNode = createPlatformAtPosition(position: CGPoint(x: positionX, y: positionY), ofType: type!)
                foregroundNode.addChild(platformNode)
            }
        }
        
        // Add the stars
        let stars = levelData["Stars"] as! NSDictionary
        let starPatterns = stars["Patterns"] as! NSDictionary
        let starPositions = stars["Positions"] as! [NSDictionary]
        
        for starPosition in starPositions {
            let patternX = starPosition["x"] as! Float
            let patternY = starPosition["y"] as! Float
            let pattern = starPosition["pattern"] as! NSString
            
            // Look up the pattern
            let starPattern = starPatterns[pattern] as! [NSDictionary]
            for starPoint in starPattern {
                let x = starPoint["x"] as! Float
                let y = starPoint["y"] as! Float
                let type = StarType(rawValue: starPoint["type"] as! Int)
                let positionX = CGFloat(x + patternX)
                let positionY = CGFloat(y + patternY)
                let starNode = createStarAtPosition(position: CGPoint(x: positionX, y: positionY), ofType: type!)
                foregroundNode.addChild(starNode)
            }
        }
        
        player.position = CGPoint(x: self.size.width / 2, y: 80.0)
        foregroundNode.addChild(player)
        
        tapToStartNode = SKSpriteNode(imageNamed: "TapToStart")
        tapToStartNode.position = CGPoint(x: self.size.width / 2, y: 180.0)
        hudNode.addChild(tapToStartNode)
        
        let star = SKSpriteNode(imageNamed: "Star")
        star.position = CGPoint(x: 25, y: self.size.height-30)
        hudNode.addChild(star)
        
        lblStars = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblStars.fontSize = 30
        lblStars.fontColor = SKColor.white
        lblStars.position = CGPoint(x: 50, y: self.size.height-40)
        lblStars.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        lblStars.text = String(format: "X %d", GameState.sharedInstance.stars)
        hudNode.addChild(lblStars)
        
        lblScore = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblScore.fontSize = 30
        lblScore.fontColor = SKColor.white
        lblScore.position = CGPoint(x: self.size.width-20, y: self.size.height-40)
        lblScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        
        lblScore.text = "0"
        hudNode.addChild(lblScore)
        
        motionManager.accelerometerUpdateInterval = 0.2
        
        if motionManager.isAccelerometerAvailable {
            if let queue = OperationQueue.current {
                motionManager.startAccelerometerUpdates(to: queue) {
                    (data, error) in
                    if error != nil {
                        assertionFailure("Error getting accelerometer data \(error)")
                    } else {
                        if let data = data {
                            self.xAcceleration = CGFloat(data.acceleration.x) * 1.75
                        }
                    }
                }
            }
        }
    }
    
    
    func createBackgroundNode() -> SKNode {
        let backgroundNode = SKNode()
        let ySpacing = 64.0 * scaleFactor
        
        for index in 0...19 {
            
            let node = SKSpriteNode(imageNamed:String(format: "Background%02d", index + 1))
            
            node.setScale(scaleFactor)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            node.position = CGPoint(x: self.size.width / 2, y: ySpacing * CGFloat(index))
            
            backgroundNode.addChild(node)
        }
        return backgroundNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if player.physicsBody!.isDynamic {
            return
        }
        
        tapToStartNode.removeFromParent()
        player.physicsBody?.isDynamic = true
        player.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 20.0))
    }
    
    func createStarAtPosition(position: CGPoint, ofType type: StarType) -> StarNode {
        let node = StarNode()
        let thePosition = CGPoint(x: position.x * scaleFactor, y: position.y)
        node.position = thePosition
        node.name = "NODE_STAR"
        
        node.starType = type
        var sprite: SKSpriteNode
        if type == .Special {
            sprite = SKSpriteNode(imageNamed: "StarSpecial")
        } else {
            sprite = SKSpriteNode(imageNamed: "Star")
        }
        node.addChild(sprite)
        
        node.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Star
        node.physicsBody?.collisionBitMask = 0
        node.physicsBody?.contactTestBitMask = 0
        return node
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var updateHUD = false
        player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 400.0)
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & CollisionCategoryBitmask.Player != 0) &&
            (secondBody.categoryBitMask & CollisionCategoryBitmask.Star != 0)  {
            player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 400.0)
        }
        
        let whichNode = (contact.bodyA.node != player) ? contact.bodyA.node : contact.bodyB.node
        let other = whichNode as! GameObjectNode
        updateHUD = other.collisionWithPlayer(player: player)
        
        if updateHUD  {
            lblStars.text = String(format: "X %d", GameState.sharedInstance.stars)
            lblScore.text = String(format: "%d", GameState.sharedInstance.score)
        }
    }
    
    func createPlatformAtPosition(position: CGPoint, ofType type: PlatformType) -> PlatformNode {
        let node = PlatformNode()
        let thePosition = CGPoint(x: position.x * scaleFactor, y: position.y)
        node.position = thePosition
        node.name = "NODE_PLATFORM"
        node.platformType = type
        
        var sprite: SKSpriteNode
        if type == .Break {
            sprite = SKSpriteNode(imageNamed: "PlatformBreak")
        } else {
            sprite = SKSpriteNode(imageNamed: "Platform")
        }
        node.addChild(sprite)
        node.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Platform
        node.physicsBody?.collisionBitMask = 0
        return node
    }
    
    func createMidgroundNode() -> SKNode {
        let theMidgroundNode = SKNode()
        var anchor: CGPoint!
        var xPosition: CGFloat!
        
        // Add some branches to the midground
        for index in 0...9 {
            var spriteName: String
            let r = arc4random() % 2
            if r > 0 {
                spriteName = "BranchRight"
                anchor = CGPoint(x: 1.0, y: 0.5)
                xPosition = self.size.width
            } else {
                spriteName = "BranchLeft"
                anchor = CGPoint(x: 0.0, y: 0.5)
                xPosition = 0.0
            }
            let branchNode = SKSpriteNode(imageNamed: spriteName)
            branchNode.anchorPoint = anchor
            branchNode.position = CGPoint(x: xPosition, y: 500.0 * CGFloat(index))
            theMidgroundNode.addChild(branchNode)
        }
        
        // Return the completed midground node
        return theMidgroundNode
    }
    override func update(_ currentTime: TimeInterval) {
        if gameOver {
            return
        }
        
        if Int(player.position.y) > maxPlayerY {
            GameState.sharedInstance.score += Int(player.position.y) - maxPlayerY
            maxPlayerY = Int(player.position.y)
            lblScore.text = String(format: "%d", GameState.sharedInstance.score)
        }
        
        foregroundNode.enumerateChildNodes(withName: "NODE_PLATFORM", using: {
            (node, stop) in
            let platform = node as! PlatformNode
            platform.checkNodeRemoval(playerY: self.player.position.y)
        })
        
        foregroundNode.enumerateChildNodes(withName: "NODE_STAR", using: {
            (node, stop) in
            let star = node as! StarNode
            star.checkNodeRemoval(playerY: self.player.position.y)
        })
        
        // Calculate player y offset
        if player.position.y > 200.0 {
            backgroundNode.position = CGPoint(x: 0.0, y: -((player.position.y - 200.0)/10))
            midgroundNode.position = CGPoint(x: 0.0, y: -((player.position.y - 200.0)/4))
            foregroundNode.position = CGPoint(x: 0.0, y: -(player.position.y - 200.0))
        }
        
        if Int(player.position.y) > endLevelY {
            endGame()
        }
        
        if Int(player.position.y) < maxPlayerY - 800 {
            endGame()
        }
    }
    override func didSimulatePhysics() {
        player.physicsBody?.velocity = CGVector(dx: xAcceleration * 400.0, dy: player.physicsBody!.velocity.dy)
        if player.position.x < -20.0 {
            player.position = CGPoint(x: self.size.width + 20.0, y: player.position.y)
        } else if (player.position.x > self.size.width + 20.0) {
            player.position = CGPoint(x: -20.0, y: player.position.y)
        }
    }
    
    func endGame() {
        
        gameOver = true
        // Save stars and high score
        GameState.sharedInstance.saveState()
        
        let reveal = SKTransition.fade(withDuration: 0.5)
        let endGameScene = EndGameScene(size: self.size)
        self.view!.presentScene(endGameScene, transition: reveal)
    }
    
}
