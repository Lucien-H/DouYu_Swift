//
//  AppDelegate.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/1.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 设置 Tabbar 的 tintColor
        UITabBar.appearance().tintColor = .orange
        return true
    }
}

