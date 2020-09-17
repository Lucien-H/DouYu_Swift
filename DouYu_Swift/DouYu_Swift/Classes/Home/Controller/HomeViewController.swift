//
//  HomeViewController.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/1.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    // MARK:- 懒加载属性
    lazy var pageTitleView: PageTitleView = {
        let titleFrame = CGRect(x: 0, y: 88, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    
    private lazy var pageContentView : PageContentView = {
        // 1. 确定内容分的 frame
        let contentH = kScreenH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH + 24, width: kScreenW, height: contentH)
        
        // 2.确定所有子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        childVcs.append(FunnyViewController())
        
        let pageContentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        pageContentView.delegate = self

        return pageContentView
    }()
    
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
         // 设置UI界面
        setUI()
    }
}

extension HomeViewController {
    private func setUI(){
        
        // 0.不需要调整UIScrollView的内边距
//        automaticallyAdjustsScrollViewInsets = false

        // 1.设置导航栏
       setNavigationBar()
        
        // 2.添加TitleView
        view.addSubview(pageTitleView)
        
        // 3.添加 ContentView
        view.addSubview(pageContentView)
    }
    private func setNavigationBar(){
        // 1.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", viewController: self, selector: #selector(logoAction))
        // 2.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size:size, viewController: self, selector: #selector(historyAction))
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size:size, viewController: self, selector: #selector(searchAction))
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size:size, viewController: self,selector: #selector(scanAction))
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}

// MARK: 遵守 PageTitleViewDelegate 协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setContentIndex(currentIndex: index)
    }
}

// MARK: 遵守 PageContentViewDelegate 协议
extension HomeViewController : PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


 // MARK:监听点击事件
extension HomeViewController{
    @objc fileprivate func logoAction(){
     print("logo")
        }
        
        @objc fileprivate func historyAction() {
            print("历史记录")
        }
        
        @objc fileprivate func searchAction() {
            print("搜索")
        }
        
        @objc fileprivate func scanAction() {
            print("浏览")
        }
}
