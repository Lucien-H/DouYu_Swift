//
//  FollowHeaderView.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/13.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class FollowHeaderView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []
    }
}

 // MARK: 类方法
extension FollowHeaderView{
    class func followHeaderView() -> FollowHeaderView{
        return Bundle.main.loadNibNamed("FollowHeaderView", owner: nil, options: nil)?.first as!  FollowHeaderView
    }
}
