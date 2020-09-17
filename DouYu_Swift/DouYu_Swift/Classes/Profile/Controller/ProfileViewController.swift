//
//  ProfileViewController.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/12.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

private let kProfileNormalCellID = "kProfileNormalCellID"

private let kProfileHeaderViewH : CGFloat = kScreenH * 3 / 8 + (kIsPhoneX ? 64 : 40)
private let kBarButtonItemW : CGFloat = 40.0


class ProfileViewController: BaseViewController {

     // MARK: 懒加载属性
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: -(kIsPhoneX ? 88 : 64), width: kScreenW, height: kScreenH), style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 50
        tableView.sectionHeaderHeight = 10
        tableView.sectionFooterHeight = 1
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableProfileNormalCell", bundle: nil), forCellReuseIdentifier: kProfileNormalCellID)
        return tableView
    }()
    
    // MARK: 定义属性
    fileprivate var sectionOneArray : [[String : Any]] = [["name":"开播提醒","icon_name":"app3DTouch_checkin"]
        ,["name":"务票查询","icon_name":"home_newSeacrhcon"],["name":"设置选项","icon_name":"image_my_settings"]]
    fileprivate var sectionTwoArray : [[String : Any]] = [["name":"手游中心","icon_name":"Image_handle"]]
    
    
    fileprivate lazy var profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView.profileHeaderView()
        profileHeaderView.frame = CGRect(x: 0, y: -kProfileHeaderViewH, width: kScreenW, height: kProfileHeaderViewH)
        return profileHeaderView
    }()
    
    lazy var leftBarItem: UIBarButtonItem = {
        let leftBarItem = UIBarButtonItem.init(imageName: "dyla_编辑", highImageName: "", size: CGSize(width: kBarButtonItemW, height: kBarButtonItemW), viewController: self,selector: #selector(editAction))
        return leftBarItem
    }()
    
    var rightBarItem: UIBarButtonItem {
        let rightBarItem = UIBarButtonItem.init(imageName: "video_player_danmu_send", highImageName: "", size: CGSize(width: kBarButtonItemW, height: kBarButtonItemW), viewController: self, selector: #selector(msgAction))
        return rightBarItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

 // MARK: 设置 UI 界面
extension ProfileViewController{
    override func setUpUI() {
        tableView.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        view.addSubview(tableView)
        tableView.addSubview(profileHeaderView)
        tableView.contentInset = UIEdgeInsets(top: kProfileHeaderViewH, left: 0, bottom: 0, right: 0)
        self.loadDataFinished()
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightBarItem
        super.setUpUI()
    }
}

 // MARK: 设置导航栏
extension ProfileViewController{
    override func viewWillAppear(_ animated: Bool) {
        // 设置导航栏和阴影为透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

 // MARK: 遵守 UITableView 的数据源
extension ProfileViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kProfileNormalCellID, for: indexPath) as! TableProfileNormalCell
        let array = indexPath.section == 0 ? sectionOneArray : sectionTwoArray
        cell.nameLabel.text = array[indexPath.item]["name"] as? String
        cell.iconImageView.image = UIImage(named: (array[indexPath.item]["icon_name"] as? String)!)
        return cell
    }
}



// MARK: 监听事件点击
extension ProfileViewController {
    
    @objc fileprivate func editAction() {
        print("编辑")
    }
    
    @objc fileprivate func msgAction() {
        print("消息")
    }
    
}
