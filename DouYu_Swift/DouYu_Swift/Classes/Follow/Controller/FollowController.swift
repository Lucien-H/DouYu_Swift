
//
//  FollowController.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/13.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

private let kFollowHeaderViewH : CGFloat = 120.0

class FollowController: BaseAnchorViewController {
    
    lazy var followViewModel : FollowViewModel = FollowViewModel()
    fileprivate lazy var followHeaderView: FollowHeaderView = {
        let followHeaderView = FollowHeaderView.followHeaderView()
        followHeaderView.frame = CGRect(x: 0, y: -kFollowHeaderViewH, width: kScreenW, height: kFollowHeaderViewH)
        return followHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

 // MARK: 设置 UI 界面
extension FollowController{
    override func setUpUI() {
        self.title = "关注"
        collectionView.addSubview(followHeaderView)
        collectionView.contentInset = UIEdgeInsets(top: kFollowHeaderViewH, left: 0, bottom: 0, right: 0)
        super.setUpUI()
    }
}

 // MARK: 请求数据
extension FollowController{
    override func loadData() {
        // 0.给父类赋值
        baseVM = followViewModel
        
        followViewModel.loadFollowData {
            // 1.刷新表格
            self.collectionView.reloadData()
            
            // 2.数据请求完成
            self.loadDataFinished()
        }
    }
}

extension FollowController{
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出 headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "kHeaderViewID", for: indexPath) as! CollectionHeaderView
        
        // 2.设置属性
        headerView.titleLabel.text = "推荐直播"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
}
