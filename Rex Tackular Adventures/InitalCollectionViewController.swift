//
//  InitalCollectionViewController.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 7/18/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class InitalCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var collectionView: UICollectionView?
    private let animals: [Animal] = [.Dog, .Cat, .Tiger, .Lion, .Hippo, .Bear, .Panda, .Mouse, .Ape, .Crockodile, .Fox, .Moose, .Pig, .Sheep, .Bird, .Rino, .Garaff, .Elephant]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        self.navigationController?.navigationBarHidden = true
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    func prepareCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        
        let margin: CGFloat = 40
        layout.itemSize = CGSize(width: (screenWidth - margin)/4 - 10, height: screenHeight/6)
        
        // we create the collection view object
        collectionView = UICollectionView(frame: CGRect(x: margin/2, y: 10, width: screenWidth - margin, height: screenHeight - 40), collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            assertionFailure("Collection View was nil")
            return
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "dialBtn")
        collectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        self.view.addSubview(collectionView)
    }
    
    // MARK: UICollectionViewDataSource

     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }

     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.redColor()
        let animal = animals[indexPath.row]
        let label = UILabel()
        label.text = animal.rawValue
        cell.addSubview(label)
        return cell
    }
}
