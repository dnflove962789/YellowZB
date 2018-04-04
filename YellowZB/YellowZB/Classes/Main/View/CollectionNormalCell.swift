//
//  CollectionNormalCell.swift
//  YellowZB
//
//  Created by zzr on 2018/3/12.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: CollectionBaseCell {

    //MARK:- 控件属性
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    //MARK: - 定义模型属性
    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            
            //4.房间名称
            roomNameLabel.text = anchor?.room_name
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
