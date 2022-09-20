//
//  ViewController.swift
//  AYWaterfallLayout
//
//  Created by Andy on 2022/9/20.
//

import UIKit

private let kContentCell = "kContentCell"
class ViewController: UIViewController {

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = AYWaterFallLayout()
        
        let cols = 3
        let itemMargin: CGFloat = 10
        let itemH: CGFloat = (self.view.bounds.width - CGFloat(cols + 1) * itemMargin) / CGFloat(cols)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCell)

        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }


}


extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCell, for: indexPath)
        cell.backgroundColor = .red
        
        return cell
    }
}
