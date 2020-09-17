//
//  BaseViewModel.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/12.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class BaseViewModel: NSObject {
    lazy var anchorGroups: [AnchorGroupModel] = [AnchorGroupModel]()
}

extension BaseViewModel{
    func loadAnchorData(isGroupData: Bool, urlString: String, parameters: [String : Any]? = nil, finishCallback: @escaping () -> ()){
        NetWorkTools.requestData(.get, urlString: urlString, parameters: parameters) { (result) in
            // 1.获取字典数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.判断是否分组数据
            if isGroupData{
                // 2.1字典转模型对象
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroupModel(dict: dict))
                }
            } else {
                // 2.1创建数组
                let group = AnchorGroupModel()
                // 2.2遍历 dataArray所有的字典
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                // 2.3将 group添加到 anchorGroups 里面
                self.anchorGroups.append(group)
            }
            // 3.完成回调
            finishCallback()
        }
    }
}
