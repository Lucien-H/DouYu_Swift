//
//  FunnyViewModel.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/11.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {}

extension FunnyViewModel{
    func loadFunnyData(finishedCallback: @escaping () -> ()){
        loadAnchorData(isGroupData: true, urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: nil, finishCallback: finishedCallback)
    }
}
