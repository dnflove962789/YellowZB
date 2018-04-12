//
//  AmuseViewController.swift
//  YellowZB
//
//  Created by zzr on 2018/4/8.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

private let kMenuViewH: CGFloat = 220


class AmuseViewController: BaseAnchorViewController {

    //MARK:-懒加载属性
    fileprivate lazy var amuseVm : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView: AmuseMenuView = {
       let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        
        return menuView
    }()
    
    //MARK:-系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func setUpUI() {
        super.setUpUI()
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
    
    //MARK:-请求数据
    override func loadData() {
        
        baseVM = amuseVm
        
        amuseVm.loadAmuseData {
            self.collectionView.reloadData()
            
            var tempGroups = self.amuseVm.anchorGroups
            tempGroups.removeFirst()
            
            self.menuView.groups = tempGroups
            
            self.loadDataFinished()
        }
    }
}


extension AmuseViewController {
    
}



