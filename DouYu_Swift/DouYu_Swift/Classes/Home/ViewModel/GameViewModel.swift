//
//  GameViewModel.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/9.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class GameViewModel {

    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel{
    func loadAllGameData(finshedCallback : @escaping() -> ()) {
        NetWorkTools.requestData(.get, urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters:nil) { (result) in
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.字典转模型
            for dict in dataArray{
                self.games.append(GameModel(dict: dict))
            }
            // 3.完成回调
            finshedCallback()
         }
    }
}
