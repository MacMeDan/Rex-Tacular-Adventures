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
    private let games: [Games] = [.animals, .OneThroughTen, .TenThroughTwenty, .letters, .Testing]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        self.navigationController?.isNavigationBarHidden = true
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    func prepareCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        
        let margin: CGFloat = 40
        layout.itemSize = CGSize(width: (screenWidth - margin)/3 - 10, height: screenHeight/4)
        
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

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = games[indexPath.row]
        getDestinationViewForGame(game: game)
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let game = games[indexPath.row]
        let gameImage = UIImageView()

        switch game {
        case .animals:
            gameImage.image = getRandomAnimalImage()
        default:
            gameImage.image = getRandomAnimalImage()
        }
        
        cell.addSubview(gameImage)
        cell.layout(gameImage).center().width(100).height(100)
        
        cell.backgroundColor = Color.lightBlue.base
        let label = UILabel(frame: CGRect(x: 0, y: cell.frame.height - 30, width: cell.frame.width, height: 40))
        label.text = game.rawValue
        label.textAlignment = .center
        label.textColor = Color.white
        cell.addSubview(label)
        return cell
    }
    
    func getDestinationViewForGame(game: Games) {
        switch game {
        case .animals:
            self.navigationController?.pushViewController(AnimalGameViewController(), animated: true)
        case .Testing:
            navigationController?.pushViewController(TestingCollectionViewController(), animated: true)
        case .OneThroughTen:
            navigationController?.pushViewController(NumbersGame(start: 0, end: 10), animated: true)
        case .TenThroughTwenty:
            navigationController?.pushViewController(NumbersGame(start: 10, end: 20), animated: true)
        case .letters:
            navigationController?.pushViewController(LettersGame(), animated: true)
        default:
            return
        }
    }
}
