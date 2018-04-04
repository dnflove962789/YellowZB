//
//  CollectionHeaderView.swift
//  YellowZB
//
//  Created by zzr on 2018/3/12.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    //MARK: - 空间属性
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var moreBtn: UIButton!
    
    //MARK:- 定义模型属性
    var group: AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImage.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

//MARK:- 从xib中快速创建的类方法
extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
