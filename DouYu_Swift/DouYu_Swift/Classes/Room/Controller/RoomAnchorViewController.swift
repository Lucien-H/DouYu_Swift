//
//  RoomAnchorViewController.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/14.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

fileprivate let kAnchorHeaderH : CGFloat = 300.0
private let kAnchorDynamicCellID = "kAnchorDynamicCellID"

class RoomAnchorViewController: BaseTableViewController {

    fileprivate lazy var anchorHeaderView: AnchorDynamicHeaderView = {
        let anchorHeaderView = AnchorDynamicHeaderView.anchorDynamicHeaderView()
        anchorHeaderView.frame = CGRect(x: 0, y: -kAnchorHeaderH, width: kScreenW, height: kAnchorHeaderH)
        return anchorHeaderView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

 // MARK: 设置 UI 界面
extension RoomAnchorViewController{
    override func setUpUI() {
        count = 10
        tableView.rowHeight = 300
        tableView.register(UINib(nibName: "AnchorDynamicCell", bundle: nil), forCellReuseIdentifier: kAnchorDynamicCellID)
        tableView.contentInset = UIEdgeInsets(top: kAnchorHeaderH, left: 0, bottom: 0, right: 0)
        tableView.addSubview(anchorHeaderView)
        super.setUpUI()
    }
}

 // MARK: 重写代理方法使用不同的 cell
extension RoomAnchorViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kAnchorDynamicCellID, for: indexPath) as! AnchorDynamicCell
        return cell
    }
}
