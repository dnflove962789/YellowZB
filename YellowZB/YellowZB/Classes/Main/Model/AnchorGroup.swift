//
//  AnchorGroup.swift
//  YellowZB
//
//  Created by zzr on 2018/3/14.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
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
    //该组现实的标题
    @objc var tag_name: String!
    //该组显示的图标
    @objc var icon_url: String = "home_header_normal"
    //定义主播模型对象数组
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    
     init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override init() {
        
    }
    
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list" {
//            if let dataArray = value as? [[String:NSObject]] {
//                for dict in dataArray {
//                    anchors.append(AnchorModel(dict: dict))
//                }
//            }
//        }
//        if key == "tag_name" {
//            self.tag_name = value as! String
//        }
//    }
}
