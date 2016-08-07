//
//  Public.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 8/4/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit

public var animalImage: UIImage!
public let animals: [Animal] = [.Dog, .Cat, .Tiger, .Lion, .Hippo, .Bear, .Panda, .Mouse, .Ape, .Crockadile, .Fox, .Moose, .Pig, .Sheep, .Bird, .Rino, .Garaff, .Elephant]


public func getRandomAnimalImage() -> UIImage {
    
    let randomIndex = Int(arc4random_uniform(UInt32(animals.count)))
    animalImage = UIImage(named: animals[randomIndex].rawValue)!
    return animalImage
}

public func getRandomAnimal() -> Animal {
    let randomIndex = Int(arc4random_uniform(UInt32(animals.count)))
    return animals[randomIndex]
}