//
//  FunnyViewController.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/13.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8.0

class FunnyViewController: BaseAnchorViewController {

     // MARK: 懒加载模型对象
  fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
}


extension FunnyViewController{
    override func setUpUI() {
        super.setUpUI()
        
        // 1.重写 layout 除去 header
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        
        // 2.设置内边距
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}


extension FunnyViewController{
    override func loadData() {
         // MARK: 1.给父类中的 viewmodel 赋值
        baseVM = funnyVM
        
        // 2.请求数据
        funnyVM.loadFunnyData {
            // 2.1刷新表哥
            self.collectionView.reloadData()
            // 2.2 数据请求完成
            self.loadDataFinished()
        }
    }
}
