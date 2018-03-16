//
//  AnchorModel.swift
//  YellowZB
//
//  Created by zzr on 2018/3/15.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class AnchorModel : NSObject {
    //房间id
    @objc var room_id: Int = 0
    //房间图片对应的urlString
    @objc var vertical_src: String = ""
    //0.电脑直播 1。手机直播
    @objc var isVertical: Int = 0
    //房间名称
    @objc var room_name: String = ""
    //主播昵称
    @objc var nickname: String = ""
    //在线人数
    @objc var online: Int = 0
    //所在城市
    @objc var anchor_city = ""
    
    
    init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    //没有用到的属性，可重写这个方法就不报错
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
