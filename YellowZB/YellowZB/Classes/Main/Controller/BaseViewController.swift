 //
//  BaseViewController.swift
//  YellowZB
//
//  Created by Rong on 2018/4/12.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - 定义属性
    var contentView: UIView?

    //懒加载属性
    fileprivate lazy var animImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ""))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "")!, UIImage(named: "")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    
    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }

    func setUpUI() {
        
        //1.隐藏view
        contentView?.isHidden = true
        
        //2.添加动画
        view.addSubview(animImageView)
        
        //3.执行动画
        animImageView.startAnimating()
        
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        animImageView.stopAnimating()
        
        animImageView.isHidden = true
        
        contentView?.isHidden = false
    }
}
 
