//
//  AnchorDynamicHeaderView.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/15.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class AnchorDynamicHeaderView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []
    }
}

extension AnchorDynamicHeaderView{
    class func anchorDynamicHeaderView() -> AnchorDynamicHeaderView{
        return Bundle.main.loadNibNamed("AnchorDynamicHeaderView", owner: nil, options: nil)?.first as! AnchorDynamicHeaderView
    }
}
