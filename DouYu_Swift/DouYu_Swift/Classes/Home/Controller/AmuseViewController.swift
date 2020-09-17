//
//  AmuseViewController.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/13.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    
    // MARK: 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.给父类中 viewModel 进行赋值
        baseVM = amuseVM
        
        // 2.请求数据
        amuseVM.loadAmuseData {
            // 2.1刷新表哥
            self.collectionView.reloadData()
            
            // 2.2调整数据
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            
            // 3. 请求完成
            self.loadDataFinished()
        }
    }
    
}

// 设置 UI 界面
extension AmuseViewController{
    override func setUpUI() {
        super.setUpUI()
        
        // 将菜单的 view添加到 collectionview 中
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}


