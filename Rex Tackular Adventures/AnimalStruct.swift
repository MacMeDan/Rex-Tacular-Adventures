//
//  animalCellCollectionViewCell.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 7/18/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//
import UIKit
import Material

public enum Name: String {
    case Dog        = "Dog"
    case Cat        = "Cat"
    case Tiger      = "Tiger"
    case Lion       = "Lion"
    case Hippo      = "Hippo"
    case Bear       = "Bear"
    case Panda      = "Panda"
    case Mouse      = "Mouse"
    case Ape        = "Ape"
    case Crock      = "Crock"
    case Fox        = "Fox"
    case Moose      = "Moose"
    case Pig        = "Pig"
    case Sheep      = "Sheep"
    case Bird       = "Bird"
    case Rino       = "Rino"
    case Garaff     = "Garaff"
    case Elephant   = "Elephant"
}

enum Type {
    case feline
    case reptile
    case none
}

func getType(name: Name) -> Type {
    switch name {
    case .Cat, .Lion, .Tiger, .Dog:
        return .feline
    default:
        return .none
    }
}

public struct Animal {
    let type: Type
    let color: UIColor
    let name : Name
    let size : CGFloat
    init(hasArms: Bool = false, name: Name, size: CGFloat) {
        self.type = getType(name)
        self.size = size
        self.name = name
        self.color = getColor(name)
    }
}

public let Names: [Name] = [.Dog, .Cat, .Tiger, .Lion, .Hippo, .Bear, .Panda, .Mouse, .Ape, .Crock, .Fox, .Pig, .Sheep, .Bird, .Rino, .Elephant]


public var Animals: [Animal] = []

func getColor(name: Name) -> UIColor {
    switch  name {
    case .Ape:
        return MaterialColor.grey.base
    case .Bear:
        return MaterialColor.brown.base
    case .Elephant, .Hippo, .Bird:
        return MaterialColor.blue.lighten2
    case  .Lion, .Tiger:
        return MaterialColor.orange.lighten4
    case .Crock:
        return MaterialColor.green.base
    case .Dog:
        return MaterialColor.grey.base
    case .Rino, .Mouse:
        return MaterialColor.grey.darken1
    case .Fox:
        return MaterialColor.red.accent1
    case .Panda, .Sheep, .Cat:
        return MaterialColor.grey.lighten4
    case .Pig:
        return MaterialColor.pink.accent1
    default:
        return MaterialColor.yellow.base
    }
}

public func getRandomAnimal() -> Animal {
    let randomIndex = Int(arc4random_uniform(UInt32(Names.count - 1)))
    return Animals[randomIndex]
}

public func getRandomAnimalImage() -> UIImage {

    let randomIndex = Int(arc4random_uniform(UInt32(Names.count)))
    animalImage = UIImage(named: Names[randomIndex].rawValue)!
    return animalImage
}