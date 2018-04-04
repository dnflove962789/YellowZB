//
//  GameViewModel.swift
//  YellowZB
//
//  Created by zzr on 2018/4/3.
//  Copyright © 2018年 zzr. All rights reserved.
//

import UIKit

class GameViewModel{
    
    lazy var games: [GameModel] = []
    
}

extension GameViewModel {
    func loadAllGameData(finishedCallback: @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, UILString: "http://capi.douyucdn.cn/api/v1/getColumnDetail") { (result) in
            guard let resultDict = result as? [String:Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String:Any]] else {return}
            
            for dict in dataArray[0...60] {
                self.games.append(GameModel(dict: dict))
            }
            
            finishedCallback()
        }
    }
}
