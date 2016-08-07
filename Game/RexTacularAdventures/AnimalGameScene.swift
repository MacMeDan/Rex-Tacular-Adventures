//
//  GameScene.swift
//  RexTacularAdventures
//
//  Created by P D Leonard on 7/29/16.
//  Copyright (c) 2016 MacMeDan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    private let animals: [Animal] = [.Dog, .Cat, .Tiger, .Lion, .Hippo, .Bear, .Panda, .Mouse, .Ape, .Crockadile, .Fox, .Moose, .Pig, .Sheep, .Bird, .Rino, .Garaff, .Elephant]
    let Crate = SKSpriteNode(imageNamed: "Crate")
    let CrateAni = CrateAnimationsView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    var animalSprite = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "What Animal is this!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - 50)
        self.addChild(myLabel)
        self.addChild(CrateAni)
        Crate.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        Crate.zPosition = 0
        self.addChild(Crate)
        setupAnimal()
        backgroundColor = UIColor.darkGrayColor()
    }
    
    func getRandomAnimal() -> SKSpriteNode {
        let randomIndex = Int(arc4random_uniform(UInt32(animals.count)))
        let animal = SKSpriteNode(imageNamed: animals[randomIndex].rawValue)
        animal.name = "Animal"
        print(animal)
        return animal
    }
    
    func getCenterPosition() -> CGPoint {
        return CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
    }
    
   
    func removeAnimal() {
        self.childNodeWithName("Animal")?.removeFromParent()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        
        if Crate.hidden {
            Crate.hidden = false
            removeAnimal()
        } else {
            Crate.hidden = true
            setupAnimal()
            addChild(animalSprite)
        }
        
    }
    
    func setupAnimal() {
        animalSprite = getRandomAnimal()
        animalSprite.xScale = 5.0
        animalSprite.yScale = 5.0
        animalSprite.position = getCenterPosition()
        animalSprite.zPosition = 100
        
        print(animalSprite)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
