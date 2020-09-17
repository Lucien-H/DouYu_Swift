//
//  CollectionHeaderView.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/12.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    // MARK: 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
    // MARK: 定义属性
    var group: AnchorGroupModel? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}

// MARK: 从 xib 中快速创建类方法
extension CollectionHeaderView{
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
