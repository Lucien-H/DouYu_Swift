//
//  AmuseMenuView.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/10.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {
    
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    // MARK: 定义属性
    var groups : [AnchorGroupModel]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    // MARK: 从Xib中加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
        autoresizingMask = []
    }
    
    // MARK: 修改 layout
    override func layoutSubviews() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
    
}

// MARK: 从 Nib 加载 view
extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView{
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

// MARK: 实现数据源方法
extension AmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil { return 0 }
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuViewCell
        
        // 2.给 cell 设置数据
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    
    private func setupCellDataWithCell(cell: AmuseMenuViewCell, indexPath: IndexPath){
        // 0页 ： 0 ~ 7
        // 1页 ： 8 ~ 15
        // 2页 ： 16 ~ 23
        
        //1. 取出起始位置 & 终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        //2. 判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        //3. 取出数据，并赋值给 cell
        cell.groups = Array(groups![startIndex...endIndex])
    }
}


// MARK: 根据 collectionview 的偏移量设置 pageControl 选择的下标
extension AmuseMenuView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
