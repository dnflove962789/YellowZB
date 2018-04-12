//
//  BaseAnchorViewController.swift
//  YellowZB
//
//  Created by zzr on 2018/4/8.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10

private let kHeaderViewID = "kHeaderViewID"
private let kHeaderViewH: CGFloat = 50

let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2

let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"
let kNormalItemH = kNormalItemW * 3/4
let kPrettyItemH = kNormalItemW * 4/3


class BaseAnchorViewController: BaseViewController {

    //MARK:-定义属性
    var baseVM: BaseViewModel!
    lazy var collectionView: UICollectionView = {[unowned self] in
        //1。创建布局
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        
        
        //2.创建uicollectionview
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        return collectionView
        }()
    //MARK:-系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
        loadData()
    }
    
    //MARK:- 设置ui界面
    override func setUpUI() {
        //1.给父类中内容view的引用进行赋值
        contentView = collectionView
        //2.添加collectionView
        view.addSubview(collectionView)
        
        super.setupUI()
        
    }

    // MARK:- 请求数据
    func loadData() {
    }
}


extension BaseAnchorViewController {
    
}


extension BaseAnchorViewController {
    
}

//MARK:-数据源
extension BaseAnchorViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的headerview
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
       
        //2.取出模型
        headerView.group = self.baseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    
}

//MARK:- 代理
extension BaseAnchorViewController : UICollectionViewDelegate {
    
}
