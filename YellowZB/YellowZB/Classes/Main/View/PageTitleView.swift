//
//  PageTitleView.swift
//  YellowZB
//
//  Created by zzr on 2018/3/6.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

//跟下面的class对应所以继承class
protocol PageTitleViewDelegate: class {
    //代理以类名开头
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}

//MARK: - 定义常量
private let kscrollLineH: CGFloat = 2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {

    //MARK:- 定义属于
    private var titles: [String]
    private var currentIndex = 0
    weak var delegate: PageTitleViewDelegate?
    
    //MARK: - 懒加载属性
    private lazy var titleLabels: [UILabel] = [UILabel]()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        //新的设置UIScrollView的内边距的方法，这样才可以显示内容
        scrollView.contentInsetAdjustmentBehavior = .never
        
        
        scrollView.frame = bounds
        return scrollView
    }()
    
    private lazy var scrollLine: UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //MARK:- 自定义够赞函数，frame系统的
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //设置ui界面
        setupUI()
    }	
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 设置UI界面
extension PageTitleView{
    private func setupUI(){
        //1。添加UIScrollView
        addSubview(scrollView)
        
        //2.添加title对应的label
        setupTitleLabels()
        
        //3.设置底线和滚动的滑块
        setupButtomMenuAndScrollLine()
    }
    
    private func setupTitleLabels() {
        
        //0.确定label的一些frame的值
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kscrollLineH
        let labelY: CGFloat = 0
        
        for(index, title) in titles.enumerated() {
            //1.创建UIlabel
            let label = UILabel()
            
            //2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            
            label.textAlignment = .center
            
            //3.设置label的frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self , action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupButtomMenuAndScrollLine() {
        //1.设置底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLine,获取第一个label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        //2.2设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kscrollLineH, width: firstLabel.frame.width, height: kscrollLineH)
    }
    
}

//MARK: -监听label的点击
extension PageTitleView {
    @objc private func titleLabelClick(_ tapGes: UITapGestureRecognizer) {
        //1.获取当前label的下标值
        guard let currentLabel = tapGes.view as? UILabel else {return}
        //同一个就返回
        if currentLabel.tag == currentIndex {return}
        
        //2.获取之前label
        let oldLabel = titleLabels[currentIndex]
        
        //3.切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //4.保存最新的label的下标值
        currentIndex = currentLabel.tag
        
        //5.滚动条位置发生改变
        let scrollLineX = CGFloat( currentLabel.tag ) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
}

//MARK: - 对外暴露的方法
extension PageTitleView {
    func setTitleWithProgreee(progeress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //1.取出sourceLabel、targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2、处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progeress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.颜色的渐变（复杂）
        //3.1取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        //3.2变化souceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progeress, g: kSelectColor.1 - colorDelta.1 * progeress, b: kSelectColor.2 - colorDelta.2 * progeress)
        //3.3变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progeress, g: kNormalColor.1 + colorDelta.1 * progeress, b: kNormalColor.2 + colorDelta.2 * progeress)
        
        //4.记录最新的index
        currentIndex = targetIndex
    }
}
