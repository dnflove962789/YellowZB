//
//  AmuseViewModel.swift
//  YellowZB
//
//  Created by zzr on 2018/4/8.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
    
}

extension AmuseViewModel  {
    func loadAmuseData(finishCallback : @escaping () -> ())  {
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2",parameters: nil, finishedCallback : finishCallback)

        
    }
}
