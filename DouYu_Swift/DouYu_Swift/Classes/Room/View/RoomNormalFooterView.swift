//
//  RoomNormalFooterView.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/14.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit
import ExpandingMenu

class RoomNormalFooterView: UIView {
    
    @IBOutlet weak var menuView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        menuButtons()
    }
}

// MARK: 创建类方法供外界调用
extension  RoomNormalFooterView{
    class func roomNormalFooterView() -> RoomNormalFooterView{
        return Bundle.main.loadNibNamed("RoomNormalFooterView", owner: nil, options: nil)?.first as! RoomNormalFooterView
    }
}

// MARK: 创建 menu按钮
extension RoomNormalFooterView{
    private func menuButtons(){
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: menuView.bounds.size), image: UIImage(named: "dy_send_gift_btn_big_pressed")!, rotatedImage: UIImage(named: "dy_send_gift_btn_big_pressed")!)
        menuButton.bottomViewColor = .white
        
        let item1 = ExpandingMenuItem(size: menuView.bounds.size, image: UIImage(named: "dy_send_gift_btn_big_pressed")!, highlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed"), backgroundImage: UIImage(named: "dy_send_gift_btn_big_pressed"), backgroundHighlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed")) { () -> Void in
            // Do some action
        }
        
        let item2 = ExpandingMenuItem(size: menuView.bounds.size, image: UIImage(named: "dy_send_gift_btn_big_pressed")!, highlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed"), backgroundImage: UIImage(named: "dy_send_gift_btn_big_pressed"), backgroundHighlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed")) {
            // Do some action
        }
        
        let item3 = ExpandingMenuItem(size: menuView.bounds.size, image: UIImage(named: "dy_send_gift_btn_big_pressed")!, highlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed"), backgroundImage: UIImage(named: "dy_send_gift_btn_big_pressed"), backgroundHighlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed")) {
            // Do some action
        }
        
        let item4 = ExpandingMenuItem(size: menuView.bounds.size, image: UIImage(named: "dy_send_gift_btn_big_pressed")!, highlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed"), backgroundImage: UIImage(named: "dy_send_gift_btn_big_pressed"), backgroundHighlightedImage: UIImage(named: "dy_send_gift_btn_big_pressed")) {
            // Do some action
        }
        
        menuButton.addMenuItems([item1, item2, item3, item4])
        menuView.addSubview(menuButton)
    }
}
