//
//  FunnyViewModel.swift
//  YellowZB
//
//  Created by zzr on 2018/4/9.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class FunnyViewModel : BaseViewModel {
   
}

extension FunnyViewModel  {
    func loadFunnyData(finishedCallback: @escaping () -> ())  {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3?limit=30", finishedCallback: finishedCallback)
    }
}
