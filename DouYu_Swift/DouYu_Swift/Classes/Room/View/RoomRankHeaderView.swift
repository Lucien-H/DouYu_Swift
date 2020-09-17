//
//  RoomRankHeaderView.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/15.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class RoomRankHeaderView: UIView {
    
    // MARK: 控件属性
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var bgImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []
    }
}

 // MARK: 创建一个类方法供外界调用
extension RoomRankHeaderView{
    class func roomRankHeaderView() -> RoomRankHeaderView{
        return Bundle.main.loadNibNamed("RoomRankHeaderView", owner: nil, options: nil)?.first as! RoomRankHeaderView
    }
}
