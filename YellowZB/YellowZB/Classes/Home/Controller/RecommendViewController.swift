//
//  RecommendViewController.swift
//  YellowZB
//
//  Created by zzr on 2018/3/9.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kItemH = kItemW * 3/4

class RecommendViewController: UIViewController {

    //MARK: - 懒加载属性
    private lazy var collectionView: UICollectionView = {[unowned self] in
        //1。创建布局
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        
        print(self.view.bounds)
        print(CGRect.zero)
        //2.创建uicollectionview
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        //collectionView.backgroundColor = UIColor.blue
        return collectionView
    }()
    
    //MARK: - 系统回调函数
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - 设置UI界面内容
extension RecommendViewController {
    private func setupUI() {
        //1.将uicollectionView添加到控制爱View中
        view.addSubview(collectionView)
    }
}
