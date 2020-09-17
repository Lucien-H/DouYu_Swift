//
//  NetWorkTools.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/12.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetWorkTools {
    class func requestData(_ type: MethodType, urlString: String, parameters: [String : Any]? = nil, finishCallback: @escaping (_ result : Any) -> ()) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        // 发送请求
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            // 3.获取数据
            guard let result = response.result.value else{
                print(response.result.error)
                return
            }
            // 4.将结果返回
            finishCallback(result)
        }
    }
}
