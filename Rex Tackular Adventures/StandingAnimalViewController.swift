//
//  StandingAnimalViewController.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 8/4/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import Material

class StandingAnimalViewController: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = MaterialColor.cyan.base
        super.viewDidLoad()
        prepareView()
    }
    
    func prepareView() {
        view.backgroundColor = MaterialColor.grey.darken3

    }

}
