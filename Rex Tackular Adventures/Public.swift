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

public let Names: [Name] = [.Dog, .Cat, .Tiger, .Lion, .Hippo, .Bear, .Panda, .Mouse, .Ape, .Crock, .Fox, .Pig, .Sheep, .Bird, .Rino, .Elephant]

public var Animals: [Animal] = []

public func setupAnimals() {
    Animals.append(Animal(name: Name.Dog,     size: 1.0))
    Animals.append(Animal(name: Name.Ape,     size: 2.0))
    Animals.append(Animal(name: Name.Cat,     size: 1.0))
    Animals.append(Animal(name: Name.Tiger,   size: 1.5))
    Animals.append(Animal(name: Name.Hippo,   size: 2.6))
    Animals.append(Animal(name: Name.Bear,    size: 2.4))
    Animals.append(Animal(name: Name.Panda,   size: 2.4))
    Animals.append(Animal(name: Name.Mouse,   size: 0.5))
    Animals.append(Animal(name: Name.Crock,   size: 1.6))
    Animals.append(Animal(name: Name.Fox,     size: 1.2))
    Animals.append(Animal(name: Name.Pig,     size: 1.3))
    Animals.append(Animal(name: Name.Sheep,   size: 1.3))
    Animals.append(Animal(name: Name.Bird,    size: 0.6))
    Animals.append(Animal(name: Name.Rino,    size: 2.3))
    Animals.append(Animal(name: Name.Elephant,size: 2.6))
}


func getColor(name: Name) -> UIColor {
    switch  name {
    case .Ape:
        return MaterialColor.grey.base
    case .Bear:
        return MaterialColor.brown.base
    case .Bird:
        return MaterialColor.blue.lighten2
    case  .Lion, .Tiger:
        return MaterialColor.orange.lighten4
    case .Crock:
        return MaterialColor.green.base
    case .Dog:
        return MaterialColor.grey.base
    case .Elephant, .Hippo, .Rino, .Mouse:
        return MaterialColor.grey.darken1
    case .Fox:
        return MaterialColor.red.accent1
    case .Panda, .Sheep, .Cat:
        return MaterialColor.grey.lighten4
    case .Pig:
        return MaterialColor.pink.accent1
    default:
        return MaterialColor.purple.base
    }

}

public func getRandomAnimalImage() -> UIImage {
    
    let randomIndex = Int(arc4random_uniform(UInt32(Names.count)))
    animalImage = UIImage(named: Names[randomIndex].rawValue)!
    return animalImage
}

public func getRandomAnimal() -> Animal {
    let randomIndex = Int(arc4random_uniform(UInt32(Names.count - 1)))
    return Animals[randomIndex]
}
