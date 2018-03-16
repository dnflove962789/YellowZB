//
//  RecommendViewModel.swift
//  YellowZB
//
//  Created by zzr on 2018/3/14.
//  Copyright © 2018年 zzr. All rights reserved.
//
/*
 1请求01数组，并转成模型对象
 2对数据进行排序
 3显示headerview内容
 */

import UIKit
import Alamofire

class RecommendViewModel {
    //MARK: - 懒加载属性
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    private lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    private lazy var prettyGroup: AnchorGroup = AnchorGroup()
    
}

//MARK: - 发送网络请求
extension RecommendViewModel {
    func ruquestData(_ finishCallBack : @escaping () -> ()) {
        
        let gd = DispatchGroup()
        
        //进入组
        gd.enter()
        //1.请求第一部分推荐数据
        NetworkTools.requestData(type: .GET, UILString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=\(NSDate.getCurrentTime())", parameters: nil) { (result) in
            //1.将result转成字段类型
            guard let resultDict = result as? [String:Any] else {return}
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String:Any]] else {return}
            //3.遍历数组，获取字典，并且将
            self.bigDataGroup = AnchorGroup()
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_url = "home_header_hot"
            for dict in dataArray {
                let an = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(an)
            }
            //离开组
            gd.leave()
        }
        
        gd.enter()
        //2.请求第二部分颜值数据
        NetworkTools.requestData(type: .GET, UILString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=\(NSDate.getCurrentTime())", parameters: nil) { (result) in
           
            //1.将result转成字段类型
            guard let resultDict = result as? [String:Any] else {return}
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String:Any]] else {return}
            //3.遍历数组，获取字典，并且将
            self.prettyGroup = AnchorGroup()
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_url = "home_header_phone"
            for dict in dataArray {
                let an = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(an)
            }
            gd.leave()
        }
        
        
        //3.请求后面游戏数据
       gd.enter()
        NetworkTools.requestData(type: .GET, UILString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: nil) { (result) in
           
            //1.将result转成字段类型
            guard let resultDict = result as? [String:Any] else {return}
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String:Any]] else {return}
            //3.遍历数组，获取字典，并且将
            
//            if let object = AnchorGroup.deserialize(from: dataArray) {
//                print(object)
//
//            }
            
            for di in dataArray {

                let group = AnchorGroup(dict: di)
                self.anchorGroups.append(group)
            }
            
            gd.leave()
        }
        
        //所有数据请求进行排序
        gd.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallBack()
        }
    }
    
    
    
   
}
