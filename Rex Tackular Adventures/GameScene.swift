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

    var player: SKNode!

    // Tap To Start node
    var tapToStartNode = SKSpriteNode(imageNamed: "TapToStart")

    var endLevelY = 0
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0.0

    // Labels for score and stars
    var lblScore: SKLabelNode!
    var lblStars: SKLabelNode!

    var maxPlayerY: Int!
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

        // Reset
        maxPlayerY = 80
        GameState.sharedInstance.score = 0
        gameOver = false

        backgroundNode = createBackgroundNode()
        addChild(backgroundNode)

        // Midground
        midgroundNode = createMidgroundNode()
        addChild(midgroundNode)

        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)

        physicsWorld.contactDelegate = self

        foregroundNode = SKNode()
        addChild(foregroundNode)

        // HUD
        hudNode = SKNode()
        addChild(hudNode)

        // Load the level
        let levelPlist = Bundle.main.path(forResource: "Level01", ofType: "plist")
        let levelData = NSDictionary(contentsOfFile: levelPlist!)!

        // Height at which the player ends the level
        endLevelY = (levelData["EndY"]! as AnyObject).integerValue!

        // Add the platforms
        let platforms = levelData["Platforms"] as! NSDictionary
        let platformPatterns = platforms["Patterns"] as! NSDictionary
        let platformPositions = platforms["Positions"] as! [NSDictionary]

        for platformPosition: NSDictionary in platformPositions {
            let patternX = (platformPosition["x"] as AnyObject).floatValue
            let patternY = (platformPosition["y"] as AnyObject).floatValue
            let pattern = platformPosition["pattern"] as! NSString

            // Look up the pattern
            let platformPattern = platformPatterns[pattern] as! [NSDictionary]
            for platformPoint in platformPattern {
                let x = (platformPoint["x"] as AnyObject).floatValue
                let y = (platformPoint["y"] as AnyObject).floatValue
                let type = PlatformType(rawValue: (platformPoint["type"]! as AnyObject).integerValue)
                let positionX = CGFloat(x! + patternX!)
                let positionY = CGFloat(y! + patternY!)
                let platformNode = createPlatformAtPosition(position: CGPoint(x: positionX, y: positionY), ofType: type!)
                foregroundNode.addChild(platformNode)
            }
        }

        // Add the stars
        let stars = levelData["Stars"] as! NSDictionary
        let starPatterns = stars["Patterns"] as! NSDictionary
        let starPositions = stars["Positions"] as! [NSDictionary]

        for starPosition in starPositions {
            let patternX = (starPosition["x"] as AnyObject).floatValue
            let patternY = (starPosition["y"] as AnyObject).floatValue
            let pattern = starPosition["pattern"] as! NSString

            // Look up the pattern
            let starPattern = starPatterns[pattern] as! [NSDictionary]
            for starPoint in starPattern {
                let x = (starPoint["x"] as AnyObject).floatValue
                let y = (starPoint["y"] as AnyObject).floatValue
                let type = StarType(rawValue: (starPoint["type"]! as AnyObject).integerValue)
                let positionX = CGFloat(x! + patternX!)
                let positionY = CGFloat(y! + patternY!)
                let starNode = createStarAtPosition(position: CGPoint(x: positionX, y: positionY), ofType: type!)
                foregroundNode.addChild(starNode)
            }
        }

        // Add the player
        player = createPlayer()
        foregroundNode.addChild(player)

        // Tap to Start
        tapToStartNode = SKSpriteNode(imageNamed: "TapToStart")
        tapToStartNode.position = CGPoint(x: self.size.width / 2, y: 180.0)
        hudNode.addChild(tapToStartNode)

        // Build the HUD

        // Stars
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

        // Score
        lblScore = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblScore.fontSize = 30
        lblScore.fontColor = SKColor.white
        lblScore.position = CGPoint(x: self.size.width-20, y: self.size.height-40)
        lblScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right

        lblScore.text = "0"
        hudNode.addChild(lblScore)

        // CoreMotion
        motionManager.accelerometerUpdateInterval = 0.2

        if motionManager.isAccelerometerAvailable
        {
            motionManager.accelerometerUpdateInterval = 0.5
            motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: { (accelerometerData, error) in
                if let acceleration = accelerometerData?.acceleration
                {
                    self.xAcceleration = (CGFloat(acceleration.x) * 0.75) + (self.xAcceleration * 0.55)
                }
            })
        }
    }

    func createBackgroundNode() -> SKNode {
        let backgroundNode = SKNode()
        let ySpacing = 64.0 * scaleFactor

        // Go through images until the entire background is built
        for index in 0...19 {

            let node = SKSpriteNode(imageNamed:String(format: "Background%02d", index + 1))

            node.setScale(scaleFactor)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            node.position = CGPoint(x: self.size.width / 2, y: ySpacing * CGFloat(index))

            backgroundNode.addChild(node)
        }
        return backgroundNode
    }


    func createPlayer() -> SKNode {
        let playerNode = SKNode()
        playerNode.position = CGPoint(x: self.size.width / 2, y: 80.0)

        let sprite = SKSpriteNode(imageNamed: "Player")
        playerNode.addChild(sprite)
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        playerNode.physicsBody?.isDynamic = false
        playerNode.physicsBody?.allowsRotation = false
        playerNode.physicsBody?.restitution = 1.0
        playerNode.physicsBody?.friction = 0.0
        playerNode.physicsBody?.angularDamping = 0.0
        playerNode.physicsBody?.linearDamping = 0.0

        playerNode.physicsBody?.usesPreciseCollisionDetection = true
        playerNode.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Player
        playerNode.physicsBody?.collisionBitMask = 0
        playerNode.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.Star | CollisionCategoryBitmask.Platform

        return playerNode
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if player.physicsBody!.isDynamic { return }

        // Remove the Tap to Start node
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

    func didBeginContact(contact: SKPhysicsContact) {
        var updateHUD = false
        let whichNode = (contact.bodyA.node != player) ? contact.bodyA.node : contact.bodyB.node
        let other = whichNode as! GameObjectNode

        updateHUD = other.collisionWithPlayer(player: player)
        if updateHUD  {
            lblStars.text = String(format: "X %d", GameState.sharedInstance.stars)
            lblScore.text = String(format: "%d", GameState.sharedInstance.score)
        }
    }

    func createPlatformAtPosition(position: CGPoint, ofType type: PlatformType) -> PlatformNode {
        let platform = PlatformNode()
        let thePosition = CGPoint(x: position.x * scaleFactor, y: position.y)
        platform.position = thePosition
        platform.name = "NODE_PLATFORM"
        platform.platformType = type

        var sprite: SKSpriteNode
        if type == .Break {
            sprite = SKSpriteNode(imageNamed: "PlatformBreak")
        } else {
            sprite = SKSpriteNode(imageNamed: "Platform")
        }
        platform.addChild(sprite)
        platform.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        platform.physicsBody?.isDynamic = false
        platform.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Platform
        platform.physicsBody?.collisionBitMask = 0
        return platform
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
        // New max height ?
        if Int(player.position.y) > maxPlayerY {

            GameState.sharedInstance.score += Int(player.position.y) - maxPlayerY

            maxPlayerY = Int(player.position.y)

            lblScore.text = String(format: "%d", GameState.sharedInstance.score)
        }

        // Remove game objects that have passed by
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

        // 1
        // Check if we've finished the level
        if Int(player.position.y) > endLevelY {
            endGame()
        }

        // 2
        // Check if we've fallen too far
        if Int(player.position.y) < maxPlayerY - 800 {
            endGame()
        }
    }

    override func didSimulatePhysics() {
        // 1
        // Set velocity based on x-axis acceleration
        player.physicsBody?.velocity = CGVector(dx: xAcceleration * 400.0, dy: player.physicsBody!.velocity.dy)
        // 2
        // Check x bounds
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
