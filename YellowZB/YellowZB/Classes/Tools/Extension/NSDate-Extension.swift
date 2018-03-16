//
//  NSDate-Extension.swift
//  YellowZB
//
//  Created by zzr on 2018/3/14.
//  Copyright © 2018年 zzr. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
