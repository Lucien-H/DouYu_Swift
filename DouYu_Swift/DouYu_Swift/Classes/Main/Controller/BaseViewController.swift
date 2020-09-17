//
//  BaseViewController.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/8/11.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: 定义属性
    var contentView : UIView?
    
    // MARK: 懒加载属性
    lazy var animateImageView: UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        imageView.isUserInteractionEnabled = false
        
        return imageView
        }()
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

extension BaseViewController {
    @objc func setUpUI(){
        // 1.先隐藏内容的 view
        contentView?.isHidden = true
        
        // 2.添加执行和动画的 UIImageView
        view.addSubview(animateImageView)
        
        // 3.给 animateImageView 执行动画
        animateImageView.startAnimating()
        
        // 4.设置 view 的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        // 1. 停止动画
        animateImageView.stopAnimating()
        
        // 2.隐藏 animateImageView
        animateImageView.isHidden = true
        
        // 3.显示 contentView
        contentView?.isHidden = false
    }
}
