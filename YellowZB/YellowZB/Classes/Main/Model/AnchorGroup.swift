//
//  AnchorGroup.swift
//  YellowZB
//
//  Created by zzr on 2018/3/14.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    //该组中对应的房价信息
    @objc var room_list: [[String:Any]]?
    {
        didSet {
            guard let room_list = room_list else {return}
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
 
   
    //该组显示的图标
    var icon_name: String = "home_header_normal"
    
    
    
    //定义主播模型对象数组
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    
//     init(dict: [String:Any]) {
//        super.init()
//        setValuesForKeys(dict)
//    }
//
//    override init() {
//        
//    }
//
//
//
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//
//    }

}
