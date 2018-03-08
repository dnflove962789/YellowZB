//
//  PageContentView.swift
//  YellowZB
//
//  Created by zzr on 2018/3/7.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    //MARK: - 定义属性
    private var childVcs: [UIViewController]
    private weak var parentViewController: UIViewController?
    private var starOffsetX: CGFloat = 0
    weak var delegate: PageContentViewDelegate?
    
    //MARK: - 懒加载属性
    private lazy var collectionView: UICollectionView = {[weak self] in
       //1.创建Layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UiCollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.dataSource = self
        //监听代理，用于滚动collectionView
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    //MARK: - 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        //设置ui
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 设置ui界面
extension PageContentView {
    private func setupUI() {
        //1.将所有子控制器添加到父控制器中
        for chlidVc in childVcs {
            parentViewController?.addChildViewController(chlidVc)
        }
        
        //2.添加UICollectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK: - 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //2.给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

//MARK: - 遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        starOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取需要的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        //2.判断是左滑还是右滑
        let currentOfsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOfsetX > starOffsetX {
            //左滑
            //计算progress比例
            progress = currentOfsetX / scrollViewW - floor(currentOfsetX / scrollViewW)
            //计算sourceIndex
            sourceIndex = Int(currentOfsetX / scrollViewW)
            //计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //如果滑过去
            if currentOfsetX - starOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            //右滑
            progress = ceil(currentOfsetX / scrollViewW) - currentOfsetX / scrollViewW
            
            targetIndex = Int(currentOfsetX / scrollViewW)
            
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            if currentOfsetX - starOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }
        
        //3.将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK: - 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int) {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y:0), animated: false)
    }
}
