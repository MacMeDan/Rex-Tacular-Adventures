//
//  InitalCollectionViewController.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 7/18/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import Material

private let reuseIdentifier = "Cell"

class InitalCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var collectionView: UICollectionView?
    private let games: [Games] = [.animals, .OneThroughTen, .TenThroughTwenty, .Testing]
    
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
        return games.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let game = games[indexPath.row]
        getViewForGame(game)
    }

     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        let game = games[indexPath.row]
        let button = FabButton()
        button.userInteractionEnabled = false
        button.backgroundColor = MaterialColor.clear
        button.setImage(getRandomAnimalImage(), forState: .Normal)
        cell.addSubview(button)
        cell.layout(button).center(offsetY: -10)
        
        cell.backgroundColor = MaterialColor.lightBlue.base
        let label = MaterialLabel(frame: CGRect(x: 0, y: cell.frame.height - 30, width: cell.frame.width, height: 40))
        label.text = game.rawValue
        label.textAlignment = .Center
        label.textColor = MaterialColor.white
        cell.addSubview(label)
        return cell
    }
    
    func getViewForGame(game: Games) {
        switch game {
        case .animals:
            self.navigationController?.pushViewController(AnimalGameViewController(), animated: true)
        case .Testing:
            navigationController?.pushViewController(TestingCollectionViewController(), animated: true)
        case .OneThroughTen:
            navigationController?.pushViewController(NumbersView(start: 0, end: 10), animated: true)
        case .TenThroughTwenty:
            navigationController?.pushViewController(NumbersView(start: 10, end: 20), animated: true)
        default:
            return
        }
    }
}
