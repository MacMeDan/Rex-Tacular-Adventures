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
    case Crockadile = "Crockadile"
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
}

enum Type {
    case feline
    case reptile
    case none
}

public struct Animal {
    let hasArms: Bool
    let type: Type
    let frontFacing: Bool
    let color: UIColor
    let name : Name
}
