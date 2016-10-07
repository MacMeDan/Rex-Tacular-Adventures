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

//MARK: UIViewcontroller exstention

extension UIViewController {
    func addBackButton() {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        view.addSubview(button)
        view.layout(button).top(20).left(20).width(50).height(50)
    }

    func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
}

