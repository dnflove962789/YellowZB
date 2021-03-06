//
//  CollectionPrettyCell.swift
//  YellowZB
//
//  Created by zzr on 2018/3/12.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {
    //MARK:- 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    //MARK: - 定义模型属性
    override var anchor: AnchorModel?  {
         didSet {
            //1.将属性传递给父类
            super.anchor = anchor
            //2.所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
