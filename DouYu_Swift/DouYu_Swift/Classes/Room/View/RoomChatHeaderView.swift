//
//  RoomChatHeaderView.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/15.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class RoomChatHeaderView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []
    }
}

 // MARK: 创建一个类方法供外界调用
extension RoomChatHeaderView{
    class func roomChatHeaderView() -> RoomChatHeaderView{
        return Bundle.main.loadNibNamed("RoomChatHeaderView", owner: nil, options: nil)?.first as! RoomChatHeaderView
    }
}
