//
//  TestingCollectionViewController.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 8/26/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import Material

private let reuseIdentifier = "testingCell"

class TestingCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var collectionView: UICollectionView?
    private let animals: [Animal] = Animals

    override func viewDidLoad() {
        super.viewDidLoad()
        print(animals)
        prepareCollectionView()
        self.navigationController?.navigationBarHidden = true
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    func prepareCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height

        let margin: CGFloat = 40
        layout.itemSize = CGSize(width: (screenWidth - margin)/4 - 10, height: screenHeight/3)

        // we create the collection view object
        collectionView = UICollectionView(frame: CGRect(x: margin/2, y: 10, width: screenWidth - margin, height: screenHeight - 40), collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            assertionFailure("Collection View was nil")
            return
        }

        collectionView.dataSource = self
        collectionView.delegate = self

        self.view.addSubview(collectionView)
    }

    // MARK: UICollectionViewDataSource

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Selected A cell a index path \(indexPath)")
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        let animal = animals[indexPath.row]
        let dancingAnimal = DancingAnimalView()
        dancingAnimal.getThisAnimalDancing(animal)
        cell.addSubview(dancingAnimal)
        cell.layout(dancingAnimal).top(10).left(10)

        let label = MaterialLabel(frame: CGRect(x: 0, y: cell.frame.height - 30, width: cell.frame.width, height: 40))
        label.text = animal.name.rawValue
        label.textAlignment = .Center
        label.textColor = MaterialColor.red.base
        dancingAnimal.addSubview(label)
        dancingAnimal.layout.center(label)

        return cell
    }

    func getViewForGame(game: Animal) {
        return
    }
}


