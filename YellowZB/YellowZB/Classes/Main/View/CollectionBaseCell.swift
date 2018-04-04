//
//  CollectionBaseCell.swift
//  YellowZB
//
//  Created by zzr on 2018/3/20.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    //MARK:- 控件属性
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    //MARK:- 定义模型
    var anchor: AnchorModel? {
        didSet {
            //0校验模型是否有值
            guard let anchor = anchor else {return}
            
            //1取出在线人数显示的文字
            var onlintStr : String = ""
            
            if anchor.online >= 1000 {
                onlintStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlintStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlintStr, for: .normal)
            
            //2.昵称的显示
            nickNameLabel.text = anchor.nickname
            
            //3.设置封面图片
            let src:String = (anchor.vertical_src).replacingOccurrences(of: "https", with: "http")
            let urr = URL(string: src)
            iconImageView.kf.setImage(with: urr)
        }
    }
}
