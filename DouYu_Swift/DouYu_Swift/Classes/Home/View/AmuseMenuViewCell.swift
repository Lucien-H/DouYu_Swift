//
//  AmuseMenuViewCell.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/10.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class AmuseMenuViewCell: UICollectionViewCell {

    // MARK: 控件属性
      @IBOutlet weak var collectionView: UICollectionView!
    
     // MARK: 数组模型
    var groups : [AnchorGroupModel]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
     // MARK: 从 xib 中加载
    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    
     // MARK: 在layoutSubviews修改 frame 更准确，在awakeFromNib拿到的 bounds 不正确
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}

extension AmuseMenuViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        // 2.给 cell 设置数据
        cell.baseGame = groups![indexPath.item]
        cell.clipsToBounds = true
        return cell
    }
}
