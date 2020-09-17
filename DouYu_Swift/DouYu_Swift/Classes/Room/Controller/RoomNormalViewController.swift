//
//  RoomNormalViewController.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/14.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

private let kFooterMargin : CGFloat = kIsPhoneX ? 20.0 : 0.0
private let KBarButtonItemW : CGFloat = 49.0
private let kNormalFooterViewH : CGFloat = 55.0
private let kNormalVideoViewH : CGFloat = kScreenH * 3 / 7


class RoomNormalViewController: UIViewController {
    

     // MARK: 懒加载属性
   fileprivate lazy var leftButtonItem: UIBarButtonItem = {
        let leftButtonItem = UIBarButtonItem(imageName: "btn_bp_back_white", highImageName: "", size: CGSize(width: KBarButtonItemW, height: KBarButtonItemW), viewController: self, selector: #selector(goBack))
        return leftButtonItem
    }()
    
    fileprivate lazy var rightButtonOneItem: UIBarButtonItem = {// 提醒
        let rightButtonOneItem = UIBarButtonItem(imageName: "dy_send_remind", highImageName: "", size: CGSize(width: KBarButtonItemW, height: KBarButtonItemW), viewController: self, selector: #selector(remindAction))
        return rightButtonOneItem
    }()
    
    lazy var rightButtonTwoItem: UIBarButtonItem = { // 开启弹幕
        let rightButtonTwoItem = UIBarButtonItem(imageName: "btn_dm_bottom", highImageName: "", size: CGSize(width: KBarButtonItemW, height: KBarButtonItemW), viewController: self, selector: #selector(tvAction))
        return rightButtonTwoItem
    }()
    
    lazy var rightButtonThreeItem: UIBarButtonItem = {// 录屏
        let rightButtonThreeItem = UIBarButtonItem(imageName: "dyla_icon_cover_upload_camera_big", highImageName: "", size: CGSize(width: KBarButtonItemW, height: KBarButtonItemW), viewController: self, selector: #selector(videoAction))
        return rightButtonThreeItem
    }()
    
    lazy var rightButtonFourItem: UIBarButtonItem = { // 弹幕
        let rightButtonFourItem = UIBarButtonItem(imageName: "btn_dm_bottom", highImageName: "", size: CGSize(width: KBarButtonItemW, height: KBarButtonItemW), viewController: self, selector: #selector(dmAction))
        return rightButtonFourItem
    }()
    
    lazy var rightButtonFiveItem: UIBarButtonItem = { // 分享
        let rightButtonFiveItem = UIBarButtonItem(imageName: "shortvideo_navItem_share", highImageName: "", size: CGSize(width: KBarButtonItemW, height: KBarButtonItemW), viewController: self, selector: #selector(shareAction))
        return rightButtonFiveItem
    }()
    
     // MARK: 懒加载底部 View
   fileprivate lazy var roomNormalFooterView: RoomNormalFooterView = {
        let roomNormalFooterView = RoomNormalFooterView.roomNormalFooterView()
        roomNormalFooterView.frame = CGRect(x: 0, y: kScreenH - kNormalFooterViewH - kFooterMargin, width: kScreenW, height: kNormalFooterViewH)
        return roomNormalFooterView
    }()
    
    fileprivate lazy var videoView: RoomNormalVideoView = {[weak self] in
        let videoView = RoomNormalVideoView.roomVideoView()
        videoView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kNormalVideoViewH)
        videoView.titles = ["聊天","主播","排行榜","贵宾(26)"]
        videoView.delegate = self
        return videoView
    }()
    
    fileprivate lazy var roomContentView: RoomNormalContentView = {[weak self] in
        let roomContentView = RoomNormalContentView.roomNormalContentView()
        roomContentView.frame = CGRect(x: 0, y: kNormalVideoViewH, width: kScreenW, height: kScreenH - kNormalVideoViewH - kFooterMargin - kNormalFooterViewH)
        roomContentView.childVcs = [RoomChatViewController(),RoomAnchorViewController(),RoomRankViewController(),RoomVipViewController()]
        roomContentView.parentViewController = self
        roomContentView.delegate = self
        return roomContentView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 设置导航栏透明色
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // 显示导航栏
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

 // MARK: 设置 UI 界面
extension RoomNormalViewController{
    fileprivate func setUI(){
        view.backgroundColor = .white
        // 添加 barButtonItem
        navigationItem.leftBarButtonItem = leftButtonItem
        navigationItem.rightBarButtonItems = [rightButtonFiveItem,rightButtonFourItem,rightButtonThreeItem,rightButtonTwoItem,rightButtonOneItem]
        // 添加 videoView 和 contentView
        view.addSubview(videoView)
        view.addSubview(roomContentView)
        view.addSubview(roomNormalFooterView)
    }
}


 // MARK: 监听点击事件
extension RoomNormalViewController{
    @objc fileprivate func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func remindAction(){
        
    }
    
    @objc fileprivate func tvAction(){
        
    }
    
    @objc fileprivate func videoAction(){
        
    }
    
    @objc fileprivate func dmAction(){
        
    }
    
    @objc fileprivate func shareAction(){
        
    }
}

 // MARK: 遵守RoomNormalVideoViewDelegate协议
extension RoomNormalViewController : RoomNormalVideoViewDelegate{
    func roomNormalVideoView(titleView: RoomNormalVideoView, selectedIndex index: Int) {
        roomContentView.setContentIndex(currentIndex: index)
        roomNormalFooterView.isHidden = index > 0 ? true : false
    }
}

 // MARK: 遵守RoomNormalContentViewDelegate协议
extension RoomNormalViewController : RoomNormalContentViewDelegate{
    func roomNormalContentView(contentView: RoomNormalContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        videoView.setTitleWithProgress(progress: progress, soureIndex: sourceIndex, targetIndex: targetIndex)
    }
}


