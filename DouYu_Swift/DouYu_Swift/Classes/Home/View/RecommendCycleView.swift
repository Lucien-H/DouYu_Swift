//
//  RecommendCycleView.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/12.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: 定义属性
    var cycleTimer : Timer?
    var cycleModels :[CycleModel]?{
        didSet {
            // 1.刷新 collectionView
            collectionView.reloadData()
            
            // 2.设置 pageControl 个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            // 3.默认滚动中间某一个位置
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            // 4.添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随父控件拉伸而滚动，即设置为 none 或者空[]
        autoresizingMask = []
        
        // 注册 cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置 collectionView 的布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: 提供一个快速创建 View 的类方法
extension RecommendCycleView{
    class func recommentCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: self, options: nil)?.first as! RecommendCycleView
    }
}

// MARK: 遵守 UICollectionViewDataSource 协议
extension RecommendCycleView : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        let cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        cell.cycleModel = cycleModel
        return cell
    }
}

// MARK: 遵守 UICollectionViewDelegate 协议
extension RecommendCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2.计算 pageControl的 currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    // 监听用户拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// MARK: 对定时器的操作方法
extension RecommendCycleView{
    
    // 创建定时器的方法
    private func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    
    // 移除定时器
    private func removeCycleTimer(){
        // 1.从运行循环中移除
        cycleTimer?.invalidate()
        
        // 2.将 timer 置为 nil
        cycleTimer = nil
    }
    
    /// 监听方法需要加@objc
    @objc private func scrollToNext(){
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        // 2.滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
