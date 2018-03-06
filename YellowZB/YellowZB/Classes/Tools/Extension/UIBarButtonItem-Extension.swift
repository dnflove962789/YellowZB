//
//  UIBarButtonItem-Extension.swift
//  YellowZB
//
//  Created by zzr on 2018/3/6.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func createItem(imageName: String, highImageName: String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: .zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
     */
    
    //swift在扩展类里推荐用便利构造函数 1.convenince开头  2.在构造函数必须明确调用一个设计的构造函数（self)
    convenience init(imageName: String, highImageName: String = "", size: CGSize = .zero) {
        //1.创建UIButton
        let btn = UIButton()
        
        //2.设置btn的图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
             btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
       
        //3.设置btn的尺寸
        if size == .zero {
            btn.sizeToFit()
        }else {
             btn.frame = CGRect(origin: .zero, size: size)
        }
       
        //4.创建UIBarButtonItem
        self.init(customView: btn)
    }
}
