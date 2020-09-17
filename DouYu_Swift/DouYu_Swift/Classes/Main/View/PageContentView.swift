//
//  PageContentView.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/3.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

// 创建代理
protocol PageContentViewDelegate : class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
     // MARK: 定义属性
    private var childVcs : [UIViewController]
    // 避免虚幻引用
    private weak var parentViewController : UIViewController?
    private var startOffsetX : CGFloat = 0.0
    private var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    lazy var collectionView: UICollectionView = {[weak self] in
        // 1.创建 lauOut
        let layOut = UICollectionViewFlowLayout()
        layOut.itemSize = (self?.bounds.size)! // 强制解包
        layOut.minimumLineSpacing = 0
        layOut.minimumInteritemSpacing = 0
        layOut.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
            // 2.创建 UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layOut)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()

    // MARK:- 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentVc
        
        super.init(frame: frame)
        
        // 设置 UI
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView {
    private func setUpUI() {
        
        // 1.将所有的自控制器添加到父控制器中 
        for childVc in childVcs {
            parentViewController?.addChild(childVc)
        }
        
        // 2.添加 UICollectionView用于在 cell 中存放控制器 view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK: 遵守 UICollectionViewDataSource 协议
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 2.给 cell 设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}


// MARK: 遵守 UICollectionViewDelegate 协议
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        // 1.定义获取需要的数据
        var progress : CGFloat = 0.0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2.判断是左滑还是右划
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        if currentOffsetX > startOffsetX { // 左滑
            // 2.1 计算 progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.2 计算 sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 2.3 计算 targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 2.4 如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 2.1 计算 progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.2 计算 targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 2.3 计算 targetIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        // 3. 将 progress、sourceIndex、targetIndex 传递给 titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK: 对外暴露的方法
extension PageContentView {
    func setContentIndex(currentIndex: Int){
        // 1.记录需要禁止执行代理方法
        isForbidScrollDelegate = true
        
        // 2.滚动到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
