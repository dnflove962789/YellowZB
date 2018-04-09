//
//  FunnyViewController.swift
//  YellowZB
//
//  Created by zzr on 2018/4/9.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

private let kTopMargin: CGFloat = 8

class FunnyViewController: BaseAnchorViewController {

    fileprivate lazy var funnyVM: FunnyViewModel = FunnyViewModel()
    
    override func setUpUI() {
        super.setUpUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
  
    
    override func loadData() {
        baseVM = funnyVM
        
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
        }
        
    }
}

