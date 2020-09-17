//
//  CollectionCycleCell.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/12.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    
    // 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // 定义模型属性
    var cycleModel : CycleModel? {
        didSet{
            titleLabel.text = cycleModel?.title
            let iconUrl = URL(string: cycleModel?.pic_url ?? "")!
            let resource = ImageResource(downloadURL: iconUrl)
            iconImageView.kf.setImage(with: resource, placeholder: UIImage(named: "Img_default"))
        }
    }
}
