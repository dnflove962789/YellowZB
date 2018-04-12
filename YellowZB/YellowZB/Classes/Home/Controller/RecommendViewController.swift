//
//  RecommendViewController.swift
//  YellowZB
//
//  Created by zzr on 2018/3/9.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH: CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
    
    //MARK: - 懒加载属性
    private lazy var recommendViewModel: RecommendViewModel = RecommendViewModel()
    
    
    //无线轮播
    private lazy var cycyleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH+kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    //推荐游戏
    private lazy var gameView: RecommendGameView = {
       let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    

    //MARK: - 请求数据
    override func loadData() {
        
        baseVM = recommendViewModel
        
        //1.请求推荐数据
        recommendViewModel.ruquestData {
            //1.展示推荐数据
            self.collectionView.reloadData()
            
            //2.将数据传递给gameview
            var groups = self.recommendViewModel.anchorGroups
            groups.removeFirst()
            groups.removeFirst()
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            
            self.gameView.groups = groups
            
            self.loadDataFinished()
        }
        
        //2.请求轮播数据
        recommendViewModel.requestCycleData {
            self.cycyleView.cycleModels = self.recommendViewModel.cycleModels
        }
        
    }
    
    //MARK: - 设置UI界面内容
    override func setUpUI() {
        //1.先调用super
        super.setUpUI()
        
        
        //2.将Cycleview添加到CollectionView
        super.collectionView.addSubview(cycyleView)
        
        //3.将gameView添加到CollectionView
        super.collectionView.addSubview(gameView)
        
        //4.设置collectionView内边距
        super.collectionView.contentInset = UIEdgeInsets(top: (kCycleViewH+kGameViewH), left: 0, bottom: 0, right: 0)
    }

}




//MARK: - UICollectionView的Delegate协议
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            //0.取出模型对象
            let group = recommendViewModel.anchorGroups[indexPath.section]
            let anchor = group.anchors[indexPath.item]
    
            //1.定义Cell
            let cell: CollectionBaseCell!
    
            //2.取出Cell
            if indexPath.section == 1{
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
    
            } else {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
    
            }
    
            //3.将模型赋值给Cell
            cell.anchor = anchor
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        } else {
            return CGSize(width: kNormalItemW, height: kNormalItemH)
        }
    }
}
