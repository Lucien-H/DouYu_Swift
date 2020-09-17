//
//  RecommendGameView.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/12.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

private let kEdgeInsetMargin : CGFloat = 10.0
private let kGameCellID = "kGameCellID"

class RecommendGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: 定义数据属性
    var groups : [BaseGameModel]?{
        didSet{
            // 刷新
            collectionView.reloadData()
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随父控件拉伸而拉伸，即设置为 none 或者空[]
        autoresizingMask = []
        
        // 注册 cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        // 给collectionView 添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}

// MARK: 快速创建的类方法
extension RecommendGameView{
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

// MARK: 遵守 UICollectionViewDataSource 协议
extension RecommendGameView : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.baseGame = groups![indexPath.item]
        return cell
    }
}
