
//
//  RoomNormalVideoView.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/14.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

// MARK: 定义常量
private let kScrollLineH : CGFloat = 4.0
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

// MARK: 定义协议
protocol RoomNormalVideoViewDelegate : class {
    func roomNormalVideoView(titleView: RoomNormalVideoView, selectedIndex index : Int)
}

class RoomNormalVideoView: UIView {
    
    // MARK: 控件属性
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var anchorVideoView: UIView!
    @IBOutlet weak var anchorInfoView: UIView!
    @IBOutlet weak var anchorInfoView_Bottom: NSLayoutConstraint!
    
    fileprivate var currentIndex : Int = 0
    var titles : [String] = []
    fileprivate var anchorInfoView_BottomH : CGFloat = 0.0
    weak var delegate : RoomNormalVideoViewDelegate?
    
    // MARK: label数组
    private lazy var titleLabels : [UILabel] = [UILabel]()
    // MARK: 添加 scrollLine
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = .orange
        return scrollLine
    }()
    
    // 更新约束
    override func layoutSubviews() {
        // 设置 UI 界面
        setupUI()
        super.layoutSubviews()
    }
}


// MARK: 设置 UI
extension RoomNormalVideoView{
    private func setupUI(){
        scrollView.scrollsToTop = false
        
        // 1.给 videoView 添加一个手势，控制 infoView隐藏显示
        let videoGes = UITapGestureRecognizer(target: self, action: #selector(isShowAnchorInfoView))
        anchorVideoView.addGestureRecognizer(videoGes)
        
        // 2.添加title对应的label
        setupTitleLabels()
        
        // 3.设置底线和滚动的滑块
        setupBottomMenuAndScrollLine()
    }
    
    private func setupTitleLabels(){
        let labelW : CGFloat = scrollView.bounds.width / CGFloat(titles.count)
        let labelH : CGFloat = scrollView.bounds.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            // 1.创建 label
            let label = UILabel()
            // 2.设置 UILabel 属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 15.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            // 3.设置 label 的 frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4.将 label 添加到 scrollview 中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 5.给 label 添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapG:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomMenuAndScrollLine(){
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: scrollView.bounds.height - lineH, width: scrollView.bounds.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加 scrollLine
        // 2.1获取第一个 label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        // 2.2设置 scrollLine 的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: scrollView.bounds.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

// MARK: 监听事件
extension RoomNormalVideoView{
    // 监听 videoView 点击
    @objc func isShowAnchorInfoView(){
        anchorInfoView_BottomH = anchorInfoView_Bottom.constant
        UIView.animate(withDuration: 0.4) {
            self.anchorInfoView_Bottom.constant = self.anchorInfoView_BottomH >= 0 ? -56 : 0
        }
    }
    
    // 监听 label 点击
    @objc private func titleLabelClick(tapG: UITapGestureRecognizer){
        
        // 处理内部逻辑
        // 0.获取当前 label
        guard let currentLabel = tapG.view as? UILabel else { return }
        // 1.如果是重复点击一个，那就直接返回
        if currentLabel.tag == currentIndex { return }
        // 2.获取之前的 label
        let oldLabel = titleLabels[currentIndex]
        // 3.切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        // 4.保存最新 label 的下标
        currentIndex = currentLabel.tag
        // 5.滚动条位置修改
        let scrollLinePosition = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLinePosition
        }
        // 处理外部逻辑
        // 6.通知代理
        delegate?.roomNormalVideoView(titleView: self, selectedIndex: currentIndex)
    }
}

 // MARK: 滑块渐变色（对外暴露）
extension RoomNormalVideoView{
    func setTitleWithProgress(progress: CGFloat, soureIndex: Int, targetIndex: Int){
        // 1.取出 sourceLabel/targetLabel
        let sourceLabel = titleLabels[soureIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3.颜色渐变（复杂）如有疑问可以重新看视频
        // 3.1取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 3.2变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.3变化的 targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4记录最新的 index
        currentIndex = targetIndex
    }
}

// MARK: 创建一个类方法供外界使用
extension RoomNormalVideoView{
    class func roomVideoView() -> RoomNormalVideoView{
        return Bundle.main.loadNibNamed("RoomNormalVideoView", owner: nil, options: nil)?.first as! RoomNormalVideoView
    }
}
