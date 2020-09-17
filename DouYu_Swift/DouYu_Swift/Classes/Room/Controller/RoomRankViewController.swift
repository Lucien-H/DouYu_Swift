//
//  RoomRankViewController.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/14.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

private let kRoomHeaderH : CGFloat = 80.0
private let kRankCellID = "kRankCellID"

class RoomRankViewController: BaseTableViewController {
    
    lazy var roomRankHeaderView: RoomRankHeaderView = {
        let roomRankHeaderView = RoomRankHeaderView.roomRankHeaderView()
        roomRankHeaderView.frame = CGRect(x: 0, y: -kRoomHeaderH, width: kScreenW, height: kRoomHeaderH)
        roomRankHeaderView.bgImageView.isHidden = true
        return roomRankHeaderView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

 // MARK: 设置 UI 界面
extension RoomRankViewController{
    override func setUpUI() {
        count = 10
        tableView.rowHeight = 80
        tableView.register(UINib(nibName: "RoomRankCell", bundle: nil), forCellReuseIdentifier: kRankCellID)
        tableView.addSubview(roomRankHeaderView)
        tableView.contentInset = UIEdgeInsets(top: kRoomHeaderH, left: 0, bottom: 0, right: 0)
        super.setUpUI()
    }
}

 // MARK: 重写代理方法
extension RoomRankViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kRankCellID, for: indexPath) as! RoomRankCell
        
        return cell
    }
}


