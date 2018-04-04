//
//  BaseGameModel.swift
//  YellowZB
//
//  Created by zzr on 2018/4/3.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    @objc var tag_name: String = ""
    @objc var icon_url: String = ""
    
    override init() {
        
    }
    
    init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
