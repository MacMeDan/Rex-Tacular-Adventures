//
//  TestingCollectionViewController.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 8/26/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

//import UIKit
//
//private let reuseIdentifier = "Cell"
//
//class TestingCollectionViewController: UICollectionViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//    // MARK: UICollectionViewDataSource
//
//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return 0
//    }
//
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
//
//        // Configure the cell
//
//        return cell
//    }
//
//    // MARK: UICollectionViewDelegate
//
//    /*
//    // Uncomment this method to specify if the specified item should be highlighted during tracking
//    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    */
//
//    /*
//    // Uncomment this method to specify if the specified item should be selected
//    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    */
//
//    /*
//    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false
//    }
//
//    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
//        return false
//    }
//
//    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
//
//    }
//    */
//
//}

import UIKit
import Material

private let reuseIdentifier = "Cell"

class TestingCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var collectionView: UICollectionView?
    private let games: [Animal] = Animals

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
        label.text = game.name.rawValue
        label.textAlignment = .Center
        label.textColor = MaterialColor.white
        cell.addSubview(label)
        return cell
    }

    func getViewForGame(game: Animal) {
        return
    }
}


