//
//  BaseViewModel.swift
//  YellowZB
//
//  Created by zzr on 2018/4/8.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups: [AnchorGroup] = []
}

extension BaseViewModel {
    func loadAnchorData(isGroupData: Bool, URLString: String,parameters: [String : Any]? = nil, finishedCallback : @escaping () -> ())  {
        NetworkTools.requestData(type: .GET, UILString: URLString) { (result) in
            guard let resultDict = result as? [String:Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String:Any]] else {return}
            
            //判断是否是分组数据
            if isGroupData {
                for dict in dataArray {
                    
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            } else {
                let group = AnchorGroup()
                for dict in dataArray {
                    
                    group.anchors.append(AnchorModel(dict: dict))
                }
                
                self.anchorGroups.append(group)
            }
            
            
            
            
            finishedCallback()
            
        }
    }
}
