
//
//  AnchorModel.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/12.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    // 房间 id
    @objc var room_id : Int = 0
    
    // 房间图片对应的 URLString
    @objc var vertical_src : String = ""
    
    // 判断是手机直播还是电脑直播
    // 0：电脑直播（普通房间） 1：手机直播（秀场直播）
    @objc var isVertical : Int = 0
    
    // 房间名称
    @objc var room_name : String = ""
    
    // 主播名称
    @objc var nickname : String = ""
    
    // 观看人数
    @objc var online : Int = 0
    
    // 所在城市
    @objc var anchor_city : String  = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
