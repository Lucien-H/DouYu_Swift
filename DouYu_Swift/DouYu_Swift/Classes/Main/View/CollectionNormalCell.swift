//
//  CollectionNormalCell.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/13.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    
    // MARK: 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    // MARK: 定义模型属性
    override var anchor: AnchorModel?{
        didSet{
            // 1.将属性传给父类
            super.anchor = anchor
            // 2.房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
}
