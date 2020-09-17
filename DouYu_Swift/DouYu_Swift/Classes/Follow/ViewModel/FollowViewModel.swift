//
//  FollowViewModel.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/13.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class FollowViewModel: BaseViewModel {
}

extension FollowViewModel{
    func loadFollowData(finishedCallback: @escaping () -> ()){
        NetWorkTools.requestData(.get, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime()]) {(result) in
            
            // 1.获取字典
            guard let resultDict = result as? [String : Any] else { return }
            
            // 2.取出 dataArray
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 3.1创建数组
            let gruop = AnchorGroupModel()
            gruop.tag_name = "推荐直播"
            gruop.icon_name = "Img_orange"
            
            // 3.2遍历 dataArray所有的字典
            for dict in dataArray {
                gruop.anchors.append(AnchorModel(dict: dict))
            }
            
            // 3.3 将 group 添加到 anchorGroups 里面
            self.anchorGroups.append(gruop)
            
            // 4.回调
            finishedCallback()
        }
    }
}
