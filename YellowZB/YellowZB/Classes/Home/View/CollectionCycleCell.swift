//
//  CollectionCycleCell.swift
//  YellowZB
//
//  Created by zzr on 2018/3/21.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    //MARK:- 控件属性
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- 定义模型属性
    var cycleModel: CycleMobdel? {
        didSet {
            titleLabel.text = cycleModel?.title
            
            let surl = (cycleModel?.pic_url)?.replacingOccurrences(of: "https", with: "http")
            let iconURl = URL(string: surl!)
            iconImageView.kf.setImage(with: iconURl)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
