
//
//  NSDate-Extension.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/13.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
