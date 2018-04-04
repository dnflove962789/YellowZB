//
//  CollectionGameCell.swift
//  YellowZB
//
//  Created by zzr on 2018/3/22.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {
    //MARK:-控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:-定义模型属性
    var baseGame: BaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
            let urlString = (baseGame?.icon_url)?.replacingOccurrences(of: "https", with: "http")
            let gameUrl = URL(string: urlString!)
            
            iconImageView.kf.setImage(with: gameUrl, placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
