//
//  RecommendGameView.swift
//  YellowZB
//
//  Created by zzr on 2018/3/21.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin: CGFloat = 10

class RecommendGameView: UIView {

    //MARK:- 定义数据属性
    var groups: [BaseGameModel]? {
        didSet {
            
            collectionView.reloadData()
        }
    }
    
    //MARK:-控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:-系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        //添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }

}

//MARK:- 快速创建的类方法
extension RecommendGameView {
    class func recommendGameView () -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

//MAR:- 遵守UICollectionView
extension RecommendGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.baseGame = groups![indexPath.item]
        
        
        
        return cell
    }
}
