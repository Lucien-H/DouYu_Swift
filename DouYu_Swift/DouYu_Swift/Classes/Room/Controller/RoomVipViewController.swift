//
//  RoomVipViewController.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/14.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

private let kRankHeaderViewH : CGFloat = 80.0
private let kRankCellID = "kRankCellID"

class RoomVipViewController: BaseTableViewController {
    
    fileprivate lazy var roomRankHeaderView: RoomRankHeaderView = {
        let roomRankHeaderView = RoomRankHeaderView.roomRankHeaderView()
        roomRankHeaderView.frame = CGRect(x: 0, y: -kRankHeaderViewH, width: kScreenW, height: kRankHeaderViewH)
        roomRankHeaderView.segmentControl.isHidden = true
        return roomRankHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: 设置 UI 界面
extension RoomVipViewController{
    override func setUpUI() {
        count = 10
        tableView.rowHeight = 40
        tableView.register(UINib(nibName: "RoomRankCell", bundle: nil), forCellReuseIdentifier: kRankCellID)
        tableView.addSubview(roomRankHeaderView)
        tableView.contentInset = UIEdgeInsets(top: kRankHeaderViewH, left: 0, bottom: 0, right: 0)
        super.setUpUI()
    }
}


extension RoomVipViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kRankCellID, for: indexPath)
        return cell
    }
}
