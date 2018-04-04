//
//  RecommendCycleView.swift
//  YellowZB
//
//  Created by zzr on 2018/3/20.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    
    //MARK:- 定义属性
    var cycleTimer: Timer?
    var cycleModels: [CycleMobdel]? {
        didSet {
            //1.刷新collectionView
            collectionView.reloadData()
            
            //2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //3.默认滚到中间某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0)*10, section: 0)
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
            
            //4.添加定时器
            removeCycleTimer()
            addCycleTime()
        }
    }
    
    //MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置控件不随父控件拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册Cell
        
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
        
    }
    
    override func layoutSubviews() {
        //设置CollectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }
}

//MARK:- 提供一个快速创建View的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//MARK:- 遵守UICollectionView数据源协议
extension RecommendCycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        //cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.purple : UIColor.green
        
        return cell
    }
    
    
}

//MARK:- 准守UICollectionView代理协议
extension RecommendCycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
        let offSetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offSetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
        
    }
    
    //拖拽移除定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    //拖拽完加入定时器
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        addCycleTime()
    }
}

//MARK:- 定时器的操作方法
extension RecommendCycleView {
    private func addCycleTime() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    private func removeCycleTimer() {
        cycleTimer?.invalidate()//从运行循环中移除
        cycleTimer = nil
    }
    
    @objc private func scrollToNext() {
        //1.获取偏移量
        let currentOffSetX = collectionView.contentOffset.x
        let offsetX = currentOffSetX + collectionView.bounds.width
        //2.滚到位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
