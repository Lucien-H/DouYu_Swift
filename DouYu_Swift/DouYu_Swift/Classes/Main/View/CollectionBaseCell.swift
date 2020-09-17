//
//  CollectionBaseCell.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/13.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {
    
    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    
    // MARK: 定义模型属性
    var anchor: AnchorModel?{
        didSet{
            // 0.校验模型是否有值
            guard let anchor = anchor else { return }
            
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            // 2.昵称显示
            nickNameLabel.text = anchor.nickname
            
            // 3.设置图片封面
            guard let iconUrl = NSURL(string: anchor.vertical_src) else { return }
            let url = ImageResource(downloadURL: iconUrl as URL)
            iconImageView.kf.setImage(with: url)
        }
    }
}
