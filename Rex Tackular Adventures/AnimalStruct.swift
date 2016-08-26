//
//  animalCellCollectionViewCell.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 7/18/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//
import UIKit

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
    case Crock      = "Crockadile"
    case Fox        = "Fox"
    case Moose      = "Moose"
    case Pig        = "Pig"
    case Sheep      = "Sheep"
    case Bird       = "Bird"
    case Rino       = "Rino"
    case Garaff     = "Garaff"
    case Elephant   = "Elephant"
}

public enum Games: String {
    case numbers    = "Numbers"
    case shapes     = "Shapes"
    case animals    = "Animals"
    case standing   = "Standing"
    case Testing    = "Testing"
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


