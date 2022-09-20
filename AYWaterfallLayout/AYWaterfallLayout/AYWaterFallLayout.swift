//
//  AYWaterfallLayout.swift
//  AYWaterfallLayout
//
//  Created by Andy on 2022/9/20.
//

import UIKit
import CoreGraphics
import Darwin

protocol AYWaterFallLayoutDatasource: AnyObject {
    
    func numberOfCols(_ waterFallLayout: AYWaterFallLayout) ->Int
    func waterFallLayout(_ waterFallLayout: AYWaterFallLayout, index: Int) -> CGSize
    
}

class AYWaterFallLayout: UICollectionViewFlowLayout {

    weak var dataSource: AYWaterFallLayoutDatasource?
    fileprivate var cellAttrs: [UICollectionViewLayoutAttributes] = []
    var totalHeights: [CGFloat] = Array(repeating: sectionInset.top, count: self.cols)
    lazy var cols: Int {
        return self.dataSource?.numberOfCols(self) ?? 2
    }()
    
    

}

// MARK:- 准备布局

extension AYWaterFallLayout {
    override func prepare() {
        super.prepare()
    
        let itemCount = collectionView?.numberOfItems(inSection: 0) ?? 2
        let cellW: CGFloat = (collectionView?.bounds.width - sectionInset.left - sectionInset.right - CGFloat(self.cols - 1) * minimumInteritemSpacing) / CGFloat(self.cols)

        for i in 0..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            var cellH: CGFloat = self.dataSource.water
            var minH: CGFloat = totalHeights.min()
            var minIndex = totalHeights.index(of: minH)
            
            
            
            var cellX: CGFloat = sectionInset.left + (minimumInteritemSpacing + cellW) * CGFloat(minIndex)
            var cellY: CGFloat = minH + minimumLineSpacing
            
            
            attr.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
       
            cellAttrs.append(attr)
            
            totalHeights[minIndex] = minH + minimumLineSpacing + cellH
        }
    
    }
    
}

// MARK:- 返回准备好的布局

extension AYWaterFallLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttrs
    }

}

// MARK:- 设置contentSize

extension AYWaterFallLayout {
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: totalHeights.max())
    }
}
