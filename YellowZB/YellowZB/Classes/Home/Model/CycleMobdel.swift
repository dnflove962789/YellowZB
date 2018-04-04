//
//  CycleMobdel.swift
//  YellowZB
//
//  Created by zzr on 2018/3/20.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class CycleMobdel: NSObject {
    @objc var title: String = ""
    @objc var pic_url: String = ""
    
    //主播信息对应字典
    @objc var room: [String:Any]? {
        didSet{
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }
    
    //主播信息对应的模型对象
    var anchor: AnchorModel?
    
    //MARK:- 自定义构造函数
     init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
