//
//  NetworkTools.swift
//  Alamofire测试
//
//  Created by zzr on 2018/3/14.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit
import Alamofire

enum MethType {
    case GET
    case POST
}

class NetworkTools {
    class func requestData(type: MethType, UILString: String, parameters: [String : String]? = nil, finishedCallback: @escaping (_ result : AnyObject) ->()) {
        
        //1.获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(UILString, method: method, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            guard let result = response.result.value else {
                print("出错了：\(response.result.error!)")
                return
            }
            finishedCallback(result as AnyObject)
        }
        
    }
}
