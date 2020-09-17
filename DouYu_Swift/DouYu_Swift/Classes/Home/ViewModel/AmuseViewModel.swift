//
//  AmuseViewModel.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/10.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: true, urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishCallback: finishedCallback)
    }
}
