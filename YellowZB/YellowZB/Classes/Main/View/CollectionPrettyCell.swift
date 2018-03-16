//
//  CollectionPrettyCell.swift
//  YellowZB
//
//  Created by zzr on 2018/3/12.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class CollectionPrettyCell: UICollectionViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    //MARK: - 定义模型属性
    var anchor: AnchorModel?  {
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
            onlineButton.setTitle(onlintStr, for: .normal)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
