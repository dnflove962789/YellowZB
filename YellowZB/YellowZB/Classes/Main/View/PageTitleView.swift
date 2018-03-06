//
//  PageTitleView.swift
//  YellowZB
//
//  Created by zzr on 2018/3/6.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class PageTitleView: UIView {

    //MARK:- 定义属于
    private var titles: [String]
    
    //MARK:- 自定义够赞函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
    }	
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
