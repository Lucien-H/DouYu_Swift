//
//  RoomChatViewController.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/14.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

private let kChatHeaderViewH : CGFloat = 100.0

class RoomChatViewController: BaseTableViewController {
    
    // MARK: 懒加载属性
    lazy var roomChatHeaderView: RoomChatHeaderView = {
        let roomChatHeaderView = RoomChatHeaderView.roomChatHeaderView()
        roomChatHeaderView.frame = CGRect(x: 0, y: -kChatHeaderViewH, width: kScreenW, height: kChatHeaderViewH)
        return roomChatHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RoomChatViewController{
    override func setUpUI() {
        tableView.addSubview(roomChatHeaderView)
        tableView.contentInset = UIEdgeInsets(top: kChatHeaderViewH, left: 0, bottom: 0, right: 0)
        count = 10
        super.setUpUI()
    }
    
}
