//
//  BaseTableViewController.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/12.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

let kChatCellID = "kChatCellID"

class BaseTableViewController: UIViewController {
    
    // MARK: 定义属性
    var count : Int = 0
    
    // 懒加载属性
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = UIColor(r: 244, g: 245, b: 245)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.rowHeight = 40
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatViewCell", bundle: nil), forCellReuseIdentifier: kChatCellID)
        return tableView
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 UI
        setUpUI()
    }
}


// MARK: 设置 UI 界面
extension BaseTableViewController {
    @objc func setUpUI() {
        view.addSubview(tableView)
    }
}


extension BaseTableViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatCellID, for: indexPath) as! ChatViewCell
        return cell
    }
}
