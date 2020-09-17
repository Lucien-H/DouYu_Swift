//
//  RecommendViewModel.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/13.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {
    
    // MARK: 懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    private lazy var bigDataGroup : AnchorGroupModel = AnchorGroupModel()
    private lazy var prettyDataGroup : AnchorGroupModel = AnchorGroupModel()
}

// MARK: 发送网络请求
extension RecommendViewModel{
    // 请求推荐数据
    func requestData(finishCallback: @escaping () -> ()){
        // 0.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime() as NSString]
        // 0.1 创建 Group
        let dispatchGroup = DispatchGroup()
        
        // 1.请求第一部分推荐的数据
        dispatchGroup.enter()
        NetWorkTools.requestData(.get, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameters) { (result) in
            // 1.1 将 result 转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 1.2根据 data，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 1.3遍历数组，获取字典，并将字典转成模型对象
            // 1.3.1 设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            // 1.3.2获取主播数据
            for dict in dataArray {
                self.bigDataGroup.anchors.append(AnchorModel.init(dict: dict))
            }
            
            // 1.4 离开组
            dispatchGroup.leave()
        }
        
        // 2.请求第二部分颜值数据
        // 进入组
        dispatchGroup.enter()
        NetWorkTools.requestData(.get, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 2.1将 result 转成字典
            guard let resultDict = result as? [String : NSObject] else {return}
            
            // 2.2根据 ”data“，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 2.3 遍历数组，获取字典，并将字典转成模型对象
            // 2.3.1 设置组的属性
            self.prettyDataGroup.tag_name = "颜值"
            self.prettyDataGroup.icon_name = "home_header_phone"
            
            // 2.3.2 获取主播数据
            for dict in dataArray{
                self.prettyDataGroup.anchors.append(AnchorModel.init(dict: dict))
            }
            
            // 2.4离开组
            dispatchGroup.leave()
        }
        
        // 3.请求游戏部分数据
        // 进入组
        dispatchGroup .enter()
        loadAnchorData(isGroupData: true, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            // 离开组
            dispatchGroup.leave()
        }
        // 4.所有数据都请求到，进行排序
        dispatchGroup.notify(queue: .main) {
            self.anchorGroups.insert(self.prettyDataGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
    
    // 请求无限轮播数据
    func requestCycleData(finishCallback : @escaping () -> ()){
        NetWorkTools.requestData(.get, urlString: "http://capi.douyucdn.cn/api/v1/slide/6", parameters: ["version":"2.300"]) { (result) in
            // 1.获取整体的字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据”data“,获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.字典转模型对象
            for dict in dataArray{
                self.cycleModels.append(CycleModel(dict: dict))
            }
            finishCallback()
        }
    }
}
