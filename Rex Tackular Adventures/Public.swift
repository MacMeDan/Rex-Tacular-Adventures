//
//  Public.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 8/4/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import Material

public var animalImage: UIImage!

public let Names: [Name] = [.Dog, .Cat, .Tiger, .Lion, .Hippo, .Bear, .Panda, .Mouse, .Ape, .Crockadile, .Fox, .Moose, .Pig, .Sheep, .Bird, .Rino, .Elephant]

public var Animals: [Animal] = []

public func setupAnimals() {
    for item in Names {
        Animals.append(Animal(hasArms: false, type: getType(item), frontFacing: true, color: getColor(item), name: item))
    }
}

func getType(name: Name) -> Type {
    switch name {
    case .Cat, .Lion, .Tiger, .Dog:
        return .feline
    default:
        return .none
    }
}

func getColor(name: Name) -> UIColor {
    switch  name {
    case .Ape:
        return MaterialColor.grey.lighten2
    case .Bear, .Moose:
        return MaterialColor.brown.base
    case .Bird:
        return MaterialColor.blue.accent3
    case .Cat, .Lion, .Tiger:
        return MaterialColor.orange.lighten4
    case .Crockadile:
        return MaterialColor.green.base
    case .Dog:
        return MaterialColor.grey.base
    case .Elephant, .Hippo, .Rino, .Mouse:
        return MaterialColor.grey.darken3
    case .Fox:
        return MaterialColor.red.accent3
    case .Panda, .Sheep:
        return MaterialColor.white
    case .Pig:
        return MaterialColor.pink.accent3
    default:
        return MaterialColor.blue.base
    }

}

public func getRandomAnimalImage() -> UIImage {
    
    let randomIndex = Int(arc4random_uniform(UInt32(Names.count)))
    animalImage = UIImage(named: Names[randomIndex].rawValue)!
    return animalImage
}

public func getRandomAnimal() -> Animal {
    let randomIndex = Int(arc4random_uniform(UInt32(Names.count)))
    return Animals[randomIndex]
}
