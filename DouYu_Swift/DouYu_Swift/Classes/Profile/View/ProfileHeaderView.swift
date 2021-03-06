//
//  ProfileHeaderView.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/12.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

private let kNormalCellW : CGFloat = kScreenW / 4
private let kProfileHeaderNormalCell = "kProfileHeaderNormalCell"

class ProfileHeaderView: UIView {
    
    // MARK: 控件属性
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
     // MARK: 定义属性
    fileprivate var names : [[String : Any]] =
        [["name":"观看历史","icon_name":"dyla_我的精彩时刻_NoData"],["name":"关注管理","icon_name":"dyla_avatar_placeholder"],["name":"鱼丸任务","icon_name":"dyla_empty_data_image"],["name":"鱼翅充值","icon_name":"gift_placeholder"]]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []
        collectionView.register(UINib(nibName: "ProfileBtnsCell", bundle: nil), forCellWithReuseIdentifier: kProfileHeaderNormalCell)
    }
    
    // 修改 frame
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置边框
        iconImageView.layer.borderColor = UIColor.yellow.cgColor
        iconImageView.layer.borderWidth = 4
        
        // 修改 item 的尺寸
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: kNormalCellW, height: kNormalCellW)
    }
}

 // MARK: 创建一个类方法供外界调用
extension ProfileHeaderView{
    class func profileHeaderView() -> ProfileHeaderView{
        return Bundle.main.loadNibNamed("ProfileHeaderView", owner: nil, options: nil)?.first as! ProfileHeaderView
    }
}

 // MARK: 遵守 UICollectionView 的数据源方法
extension ProfileHeaderView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kProfileHeaderNormalCell, for: indexPath) as! ProfileBtnsCell
        cell.nameLabel.text = names[indexPath.item]["name"] as? String
        cell.iconImageView.image = UIImage(named: names[indexPath.item]["icon_name"] as! String)
        return cell
    }
}
