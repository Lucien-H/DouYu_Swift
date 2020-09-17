//
//  BaseAnchorViewController.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/12.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

// MARK: 常量
let kNormalItemW : CGFloat = (kScreenW - kItemMargin * 3) / 2
let kNormalItemH : CGFloat = kNormalItemW * 3 / 4
let kPrettyItemH : CGFloat = kNormalItemW * 4 / 3
private let kItemMargin : CGFloat = 10.0
private let kHeaderViewH : CGFloat = 50.0


private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
let kPrettyCellID = "kPrettyCellID"


class BaseAnchorViewController: BaseViewController {
    
    // MARK: 定义属性
    var baseVM : BaseViewModel!
    lazy var collectionView: UICollectionView = {
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建 UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register((UINib(nibName: "CollectionPrettyCell", bundle: nil)), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    // 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 UI 界面
        setUpUI()
        
        // 请求数据
        loadData()
    }
}

// MARK: 设置 UI 界面
extension BaseAnchorViewController{
    override func setUpUI() {
        // 1.给父类中内容view 引用进行赋值
        contentView = collectionView
        
        // 2.再添加 collectionView
        view.addSubview(collectionView)
        
        // 3.再调用 super
        super.setUpUI()
    }
}

// MARK: 请求数据
extension BaseAnchorViewController{
    @objc func loadData(){
        
    }
}

// MARK: 遵守 UIColectionViewDataSource 协议
extension BaseAnchorViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           
           //1. 取出 headerView
           let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
           
           //2. 给 headerView 设置数据
           headerView.group = baseVM.anchorGroups[indexPath.section]
           
           return headerView
       }
}

// MARK: 遵守 UICollectionDelegate 协议
extension BaseAnchorViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1.取出主播信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item];
        // 2.判断是秀场房间还是普通房间
        anchor.isVertical == 0 ? pushNormalRoomVC() : presentShowRoomVC()
    }
    
    private func presentShowRoomVC(){
        
    }
    
    private func pushNormalRoomVC(){
       // 1.创建 vc
        let normalVC = RoomNormalViewController()
        
        // 2.push
        navigationController?.pushViewController(normalVC, animated: true)
    }
}
