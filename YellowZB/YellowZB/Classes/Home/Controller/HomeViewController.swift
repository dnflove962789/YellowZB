//
//  HomeViewController.swift
//  YellowZB
//
//  Created by zzr on 2018/3/6.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - 懒加载属性
    private lazy var pageTitleView = {
        
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: UIScreen.main.bounds.width, height: 40)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

// MARK: - 设置ui界面
extension HomeViewController {
    private func setupUI() {
        setupNavigationBar()
    }
    private func setupNavigationBar() {
        //1.设置左侧Item，即logo，有变灰的效果，用button,使用到工具类的，UIBarButton-Extension
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //2.设置右侧的Item
        //用UIBarButton-Extension的构造函数，构建历史浏览btn
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: size)
        //用UIBarButton-Extension的构造函数，构建搜索btn
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        //用UIBarButton-Extension的构造函数，构建二维码btn
        let qrcodeItem = UIBarButtonItem(imageName: "image_scan", highImageName: "image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}
