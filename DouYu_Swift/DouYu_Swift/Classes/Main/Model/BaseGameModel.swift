//
//  BaseGameModel.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/12.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    
    // MARK: 定义属性
    /// 组显示的标题
    @objc var tag_name : String = ""
    /// 游戏对应的图标
    @objc var icon_url : String = ""
    
    // MARK: 自定义构造函数
    override init() {}
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
